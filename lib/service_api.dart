import 'package:dio/dio.dart';
import 'package:pid_controller/model/pidmodel.dart';

class ServiceAPIs {
  final Dio dio = Dio();

  final BASE_URL = 'http://192.168.101.58:3000';
  // final LOCAL_URL = 'http://127.0.0.1:3000';

  Future fetchEnum() async {
    final response = await dio.get(
      '${BASE_URL}/enum',
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
    return PidModel.fromJson(response.data);
  }

  Future loadPresetByID(presetId) async {
     Map<String, dynamic> body = {
      "presetId": presetId,
    };
    final response = await dio.post(
      '${BASE_URL}/loadPreset',
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
