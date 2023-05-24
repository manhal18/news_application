import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_application/constants.dart';

class DioHelper
{
  static Dio dio;
  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: Constants.api_url+"api/",
        receiveDataWhenStatusError:true,
        headers: {
          'Content-Type': 'application/json',
        }
      ),
    );
  }
  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
  }) async
  {
    return await dio.get(
      url,
      queryParameters:query,
    );
  }
  static Future<Response> insertData({
    @required String url,
    @required String token,
  }) async
  {
    return await dio.post(
      url,
      data: { 'token': token },
    );
  }
}