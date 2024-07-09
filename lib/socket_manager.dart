import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pid_controller/service_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._();
  factory SocketManager() {
    return _instance;
  }
  IO.Socket? _socket;
  late StreamController<List<Map<String, dynamic>>> _streamController;
  IO.Socket? get socket => _socket;
  Stream<List<Map<String, dynamic>>> get dataStream => _streamController.stream;
  SocketManager._() { _streamController =StreamController<List<Map<String, dynamic>>>.broadcast(); }

  void initSocket() {
    _socket = IO.io(ServiceAPIs().BASE_URL_SOCKET, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    _socket?.on('connection', (data) {
      debugPrint('SocketManager connection: $data');
    });

    _socket?.connect();
  }


  void connectSocket() {
    debugPrint('SocketManager connectSocket() ${socket!.id}');
    _socket?.connect();
  }

  void disposeSocket() {
    debugPrint('SocketManager connectSocket() ${socket!.id}');
    _socket?.disconnect();
    _socket = null;
  }

  // void processData(dynamic data) {
  //   if (data is List<dynamic> && data.isNotEmpty) {
  //     if (data[0] is List<dynamic>) {
  //       List<dynamic> memberList = data[0];
  //       List rawData = data;
  //       List<List<dynamic>> formattedData = [memberList, ...rawData];
  //       List<Map<String, dynamic>> resultData = [];
  //       List<String> memberListAsString =
  //           memberList.map((member) => member.toString()).toList();

  //       for (int i = 1; i < formattedData.length; i++) {
  //         Map<String, dynamic> entry = {
  //           'member': memberListAsString,
  //           'data': formattedData[i].map((entry) {
  //             if (entry is num) {
  //               return entry.toDouble();
  //             }
  //             return entry;
  //           }).toList(),
  //         };
  //         resultData.add(entry);
  //       }
  //       _streamController.add(resultData);
  //     }
  //   }
  // }

  // void processData2(dynamic data) {
  //   final Map<String, dynamic>? jsonData = data as Map<String, dynamic>?;

  //   if (jsonData != null) {
  //     final List<dynamic>? dataList = jsonData['data'] as List<dynamic>?;
  //     final List<dynamic>? nameList = jsonData['name'] as List<dynamic>?;
  //     final List<dynamic>? numberList = jsonData['number'] as List<dynamic>?;
  //     final List<dynamic>? timeList = jsonData['time'] as List<dynamic>?;

  //     if (dataList != null && nameList != null) {
  //       final Map<String, dynamic> finalFormattedData = {
  //         'data': dataList,
  //         'name': nameList,
  //         'number': numberList,
  //         'time': timeList,
  //       };
  //       List<Map<String, dynamic>> listOfMaps = [finalFormattedData];
  //       // _streamController2.add(listOfMaps);
  //     }
  //   }
  // }

  // void processDataToggle(dynamic data) {
  //   for (var jsonData in data) {
  //     try {
  //       // Parse the createdAt field as a DateTime object
  //       DateTime createdAt = DateTime.parse(jsonData['createdAt']);
  //       // Create a Map to represent the display data
  //       Map<String, dynamic> displayData = {
  //         // '_id': jsonData['_id'].toString(), // Convert ObjectId to string
  //         // 'id': jsonData['id'],
  //         'name': jsonData['name'],
  //         'enable': jsonData['enable'],
  //         'content': jsonData['content'],
  //         // 'createdAt': createdAt,
  //       };
  //       // _streamControllerView.add([displayData]);
  //     } catch (e) {
  //       print('Error parsing datetime: $e');
  //     }
  //   }
  // }

  // void emitEventFromClient() {
  //   _socket?.emit('eventFromClient');
  // }

  // void emitEventFromClient2() {
  //   _socket?.emit('eventFromClient2');
  // }

  // void emitEventFromClientForce() {
  //   socket!.emit('eventFromClient_force');
  // }

  // Future<void> emitEventFromClient2Force() async {
  //   socket!.emit('eventFromClient2_force');
  // }

  // void emitToggleClient() {
  //   socket!.emit('emitToggleClientToggle');
  // }
}
