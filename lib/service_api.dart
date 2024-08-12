import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pid_controller/model/pidmodel.dart';

class ServiceAPIs {
  final Dio dio = Dio();
  final BASE_URL = 'http://30.0.0.79:3000';
  final BASE_URL_SOCKET = 'http://30.0.0.79:3001/';
  // final BASE_URL = 'http://192.168.101.58:3000';
  // final BASE_URL_SOCKET = 'http://192.168.101.58:3001/';

  Future fetchEnum() async {
    try {
      final response = await dio.get(
        '$BASE_URL/enum',
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: const Duration(seconds: 10000),
          sendTimeout: const Duration(seconds: 10000),
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      debugPrint('enum value: ${response.statusCode} ${response.data}');
      if (response.data != null) {
      return PidModel.fromJson(response.data);
    } else {
      debugPrint('Response data is null');
      return null;
    }
    } catch (e) {
      debugPrint('catch error :$e');
    }
  }
  Future stopCronJob() async {
    try {
      final response = await dio.get(
        '$BASE_URL/stop_cron',
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: const Duration(seconds: 10000),
          sendTimeout: const Duration(seconds: 10000),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      debugPrint('stopcron: ${response.statusCode} ${response.data}');
      return (response.data);
    } catch (e) {
      debugPrint('catch error :$e');
    }
  }
  Future restartCronJob() async {
    try {
      final response = await dio.get(
        '$BASE_URL/restart_cron',
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: const Duration(seconds: 10000),
          sendTimeout: const Duration(seconds: 10000),
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      debugPrint('restart_cron: ${response.statusCode} ${response.data}');
      return (response.data);
    } catch (e) {
      debugPrint('catch error :$e');
    }
  }

  Future loadPresetByID(presetId) async {
    Map<String, dynamic> body = {
      "presetId": presetId,
    };
    final response = await dio.post(
      '$BASE_URL/loadPreset',
      data: body,
      options: Options(
        contentType: Headers.jsonContentType,
        // receiveTimeout: const Duration(seconds: 10000),
        // sendTimeout: const Duration(seconds: 10000),
        // followRedirects: false,
        // validateStatus: (status) {
        //   return true;
        // },
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      ),
    );
    return (response.data);
  }
}
