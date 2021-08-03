import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/token/token_get.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/services/user/token_provider.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor({required this.dio});
  
/*  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    ClientGet client = await HiveLoad.getClient();
    String oldToken = await HiveLoad.getToken();
    UserGet user = await HiveLoad.getUser();
    TokenGet token = await TokenProvider.getToken(
        client, user.username, oldToken, 'refresh_token');

    options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${token.access_token}'
    };

    return options;
  }*/

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      //dio.interceptors.requestLock.lock();
      if ((err.error as String).contains('401')) {
        ClientGet client = await HiveLoad.getClient();
        String refreshToken = await HiveLoad.getRefreshToken();
        UserGet user = await HiveLoad.getUser();
        TokenGet token = await TokenProvider.getToken(
            client, user.username, refreshToken, 'refresh_token');
        HiveSave.saveTokens(token.access_token, token.refresh_token);

        if (token.access_token != null) {
          
          Response response;
          /*return dio.request(
            err.requestOptions.path,
            cancelToken: err.requestOptions.cancelToken,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            onReceiveProgress: err.requestOptions.onReceiveProgress,
            onSendProgress: err.requestOptions.onSendProgress,
            options: Options(
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader : 'Bearer ${token.access_token}'
              },
            ),
          );*/
          
          
        } else {
          return err;
        }
      } else {
        return err;
      }
    } catch (e) {
      throw (e);
    }
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }
  
  /*@override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
      // Do something before request is sent
      options.headers["Authorization"] = "Bearer " + token;
      return options;
    }
    
    @override
    Future onResponse(Response response, RequestInterceptorHandler handler) async {
        return response;
    }
    
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
      // Do something with response error
      if (err.response?.statusCode == 401) {
        dio.interceptors.requestLock.lock();
        dio.interceptors.responseLock.lock();
        RequestOptions options = err.response.request;
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        token = await user.getIdToken(refresh: true);
        await writeAuthKey(token);
        options.headers["Authorization"] = "Bearer " + token;

        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
        return dio.request(options.path,options: options);
      } else {
        return err;
      }
    }*/
}
