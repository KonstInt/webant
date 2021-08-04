import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/token/token_get.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/services/user/token_provider.dart';

class TokenInterceptor2 extends Interceptor {
  final Dio dio;
  
  TokenInterceptor2({required this.dio});

  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await HiveLoad.getToken();
    if (token != '') {
      options.headers = {HttpHeaders.authorizationHeader: 'Bearer ${token}'};
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    
    try{
    if(err.response != null)
    {if (err.response!.statusCode == 401) {
      String token = await HiveLoad.getRefreshToken();
      
      if (token != '') {
        ClientGet client = await HiveLoad.getClient();
        String refreshToken = await HiveLoad.getRefreshToken();
        UserGet user = await HiveLoad.getUser();
        TokenGet token = await TokenProvider.getToken(
            client, user.username, refreshToken, 'refresh_token');
        HiveSave.saveTokens(token.access_token, token.refresh_token);

        if (token.access_token != '') {
          err.requestOptions.headers = ({HttpHeaders.authorizationHeader: 'Bearer ${token.access_token}'});

          dio.fetch(err.requestOptions).then(
                (r) => handler.resolve(r),
                onError: (e) => handler.reject(e),
              );
          return;
        } else {
          handler.reject(err);
        }
      } else {
        handler.reject(err);
      }
    }}
    else{
       handler.next(err);
    }}
    catch(e){
      throw(e);
    }
   
    

    super.onError(err, handler);
  }
}