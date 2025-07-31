import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';
import 'package:simple/bean/error_message_model.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "en";
const String TOKEN = "Bearer token";
const String BASE_URL = "https://wpapi.ducafecat.tech";

class WooHttpUtil {
  static final WooHttpUtil _instance = WooHttpUtil._internal();

  factory WooHttpUtil() => _instance;

  late Dio _dio;

  // 单例初始
  WooHttpUtil._internal() {
    // header 头
    Map<String, String> header = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: TOKEN,
      DEFAULT_LANGUAGE: DEFAULT_LANGUAGE,
    };

    // 初始化选项
    var options = BaseOptions(
      baseUrl: 'https://slwl-api.itheima.net/driver',
      headers: header,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json,
    );

    // 初始化 dio
    _dio = Dio(options);

    // 拦截日志打印
    if (!kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    }

    _dio.interceptors.add(RequestInterceptors());
  }

  /// get请求
  Future<Response> get(
    String url,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  ) async {
    Options requestOptions = options ?? Options();
    Response response = await _dio.get(
      url,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// post请求
  Future<Response> post(
    String url,
    dynamic data,
    Options options,
    CancelToken? cancelToken,
  ) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.post(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// put 请求
  Future<Response> put(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.put(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// delete 请求
  Future<Response> delete(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.delete(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }
}

class RequestInterceptors extends Interceptor {
  // 发送请求
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    return handler.next(options);
  }

  // 响应
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    } else {
      handler.next(response);
    }
  }

  /// 错误
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final exception = HttpException(err.message ?? "error message");
    switch (err.type) {
      case DioExceptionType.badResponse: // 服务端自定义错误体处理
        {
          final response = err.response;
          final errorMessage = ErrorMessageModel.fromJson(response?.data);
          switch (errorMessage.statusCode) {
            // 401 未登录
            case 401:
              // 注销 并跳转到登录页面
              // _errorNoAuthLogout();
              break;
            case 404:
              break;
            case 500:
              break;
            case 502:
              break;
            default:
              break;
          }
          // 显示错误信息
          // if(errorMessage.message != null){
          //   Loading.error(errorMessage.message);
          // }
        }
        break;
      case DioExceptionType.unknown:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionTimeout:
        break;
      default:
        break;
    }
    DioException errNext = err.copyWith(
      error: exception,
    );
    handler.next(errNext);
  }
}
