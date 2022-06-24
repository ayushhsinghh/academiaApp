import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:srmacadmia/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpService {
  late Dio _dio;
  final Alice _alice = Alice(
      showNotification: true,
      darkTheme: true,
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
    // _dio.interceptors
    //     .add(DioCacheManager(CacheConfig(baseUrl: baseURL)).interceptor);
  }

  Future<Response> getRequest(
      {required String endPoint, required Map<String, dynamic> query}) async {
    Response response;

    try {
      response = await _dio.get(
        endPoint,
        queryParameters: query,
        // options: buildCacheOptions(const Duration(minutes: 5),
        //     maxStale: const Duration(minutes: 10))
      );
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
      print('Data source: cache');
    } else {
      print("Data source: Server");
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
