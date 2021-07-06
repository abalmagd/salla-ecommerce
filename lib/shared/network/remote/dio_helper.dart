import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_end_points.dart';

class DioHelper {
  static Dio dio = Dio();

  static void dioInit() {
    dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
      },
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> get({
    Map<String, dynamic> query,
    String token,
    @required String url,
  }) {
    if (token != null) {
      dio.options.headers['Authorization'] = token;
    }
    //Todo: parse data here
    return dio.get(url, queryParameters: query);
  }

  static Future<Response> post({
    Map<String, dynamic> data,
    String token,
    @required String url,
  }) {
    if (token != null) {
      dio.options.headers['Authorization'] = token;
    }
    return dio.post(url, data: data);
  }

  static Future<Response> put({
    Map<String, dynamic> data,
    String token,
    @required String url,
  }) {
    if (token != null) {
      dio.options.headers['Authorization'] = token;
    }
    return dio.put(url, data: data);
  }
}