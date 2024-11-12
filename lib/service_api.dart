import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pid_controller/model/pidmodel.dart';

class ServiceAPIs {
  final Dio dio = Dio();
  // final BASE_URL = 'http://30.0.0.79:3001';
  // final BASE_URL_SOCKET = 'http://30.0.0.79:3001/';
  // final BASE_URL = 'http://192.168.101.58:8085';
  final String BASE_URL = 'http://192.168.100.60:3001';
  final String BASE_URL2 = 'http://192.168.101.58:3000';
  


  Future fetchEnum() async {
    final String FETCH_ENUM = '${BASE_URL}/enum';
    final String FETCH_ENUM2_SLOT = '${BASE_URL2}/enum_slot';
    try {
      final response = await _getRequestWithFallback(FETCH_ENUM, FETCH_ENUM2_SLOT);
      debugPrint('enum value: ${response.statusCode} ${response.data}');
      if (response.data != null) {
        return PidModel.fromJson(response.data);
      } else {
        debugPrint('Response data is null');
        return null;
      }
    } catch (e) {
      debugPrint('fetchEnum error: $e');
    }
  }



 Future loadPresetByID(presetId) async {
    Map<String, dynamic> body = {
      "presetId": presetId,
    };
    try {
      final response = await _postRequestWithFallback('$BASE_URL/loadPreset', data: body);
      debugPrint('response data: ${response.data}');
      return response.data;
    } catch (e) {
      debugPrint('loadPresetByID error: $e');
    }
  }


 // Helper method to handle GET requests with fallback
  Future<Response> _getRequestWithFallback(String primaryUrl, String fallbackUrl) async {
    try {
      return await dio.get(
        primaryUrl,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
    } catch (e) {
      debugPrint('Primary URL failed: $e. Trying fallback URL.');
      return await dio.get(
        fallbackUrl,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
    }
  }

  // Helper method to handle POST requests with fallback
  Future<Response> _postRequestWithFallback(String url, {required Map<String, dynamic> data}) async {
    try {
      return await dio.post(
        url,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
    } catch (e) {
      debugPrint('Primary URL failed: $e. Trying secondary URL.');
      return await dio.post(
        url.replaceFirst(BASE_URL, BASE_URL2),
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
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

 
}