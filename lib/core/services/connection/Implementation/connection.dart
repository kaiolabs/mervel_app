import 'package:dio/dio.dart';

import '../interface/i_connection.dart';

class Connection implements IConnection {
  final Dio _dio = Dio();

  @override
  Future delete(String url, {Map<String, dynamic>? queryParameters, Map<String, String>? headers, body}) async {
    throw UnimplementedError();
  }

  @override
  Future<(bool, Map)> get(String url, {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) async {
    _dio.options.headers = headers;
    try {
      Response res = await _dio.get(url, queryParameters: queryParameters);
      return (true, res.data as Map);
    } catch (e) {
      return (false, {});
    }
  }

  @override
  Future post(String url, {Map<String, dynamic>? queryParameters, Map<String, String>? headers, body}) async {
    _dio.options.headers = headers;

    try {
      Response res = await _dio.post(url, data: body, queryParameters: queryParameters);
      return res.data;
    } catch (e) {
      return [];
    }
  }

  @override
  Future put(String url, {Map<String, dynamic>? queryParameters, Map<String, String>? headers, body}) async {
    throw UnimplementedError();
  }
}
