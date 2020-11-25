import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:life_wish/Model/request/SocialLoginRequest.dart';
import 'package:life_wish/Model/response/LoginResponse.dart';

import '../Model/request/LoginRequest.dart';

class Api {
  static final Api _api = Api._internal();
  static final String baseUrl = 'http://staging-api.lifewish.co/api/v1/';
  static String API_TOKEN = "";
  final Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 120000,
      receiveTimeout: 120000,
      headers: <String, dynamic>{
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      responseType: ResponseType.json));

  factory Api() {
    return _api;
  }

  Api._internal() {
    injectInterceptor();
  }

  injectInterceptor() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers["Authorization"] = "Bearer " + API_TOKEN;
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError e) async {
      return e;
    }));

    dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  Future<LoginResponse> doLogin(LoginRequest data) async {
    Response response = await dio.post("login", data: data.toJson());
    if (response != null) {
      return LoginResponse.fromJson(response.data);
    }
    return null;
  }

  Future<LoginResponse> doSocialLogin(SocialLoginRequest data) async {
    Response response = await dio.post("social-auth", data: data.toJson());
    if (response != null) {
      return LoginResponse.fromJson(response.data);
    }
    return null;
  }

  Future<String> getFacebookUserDetail(token) async {
    dio.options.baseUrl =
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token';
    final graphResponse = await dio.get("");
    return graphResponse.data;
  }

  Future<LoginResponse> userRegistration(SocialLoginRequest data) async {
    return doSocialLogin(data);
  }
}
