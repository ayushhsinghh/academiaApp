import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:srmacadmia/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpService {
  late Dio _dio;
  final Alice _alice = Alice(
      showNotification: true,
      showInspectorOnShake: true,
      darkTheme: false,
      navigatorKey: navigatorKey,
      maxCallsCount: 1000);

  String baseURL = dotenv.env['BASE_URL']!;

  HttpService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
      ),
    );

    // initializeInterceptors();
    _dio.interceptors.add(_alice.getDioInterceptor());
  }

  Future<Response> getRequest(
      {required String endPoint, required Map<String, dynamic> query}) async {
    Response response;

    try {
      response = await _dio.get(endPoint, queryParameters: query);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }, onResponse: (response, handler) {
      print('RESPONSE[${response.statusCode}] => PATH: ${response.headers}');
    }, onError: (DioError e, handler) {
      print('ERROR[${e.response?.statusCode}] => PATH: ${e.error}');
    }));
  }
}
