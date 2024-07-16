import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:youtube_bloc_clean_coding/data/exception/app_exception.dart';
import 'package:youtube_bloc_clean_coding/data/network/base_api_network.dart';
import 'package:http/http.dart' as http;

class NetworkServices implements BaseApiNetwork {
  @override
  Future getApi(String url) async {

    if(kDebugMode){
      print("ApiUrl: $url");
    }

    dynamic jsonResponce;
    try {
      final responce = await http
          .get(
            Uri.parse(url),
          )
          .timeout(
            const Duration(seconds: 50),
          );

      jsonResponce = returnResponse(responce);

      if (responce.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException('');
    } on RequestTimeOutException {
      throw FetchDataException('Time out try again');
    }

    if(kDebugMode){
      print("Jason: $jsonResponce");
    }
    return jsonResponce;
  }

  @override
  Future postApi(String url, data) async {
    dynamic jsonResponce;

    if(kDebugMode){
      print("ApiUrl: $url");
      print("PostData: $data");
    }

    try {
      final responce = await http.post(Uri.parse(url), body: data).timeout(
            const Duration(seconds: 50),
          );

      jsonResponce = returnResponse(responce);

      if (responce.statusCode == 200) {
        
      }
    } on SocketException {
      throw NoInternetException('');
    } on RequestTimeOutException {
      throw FetchDataException('Time out try again');
    }

    if(kDebugMode){
      print("Jason: $jsonResponce");
    }
    return jsonResponce;
  }

  @override
  Future deleteApi(String url) async {
    if(kDebugMode){
      print("ApiUrl: $url");
    }

    dynamic jsonResponce;

    try {
      final responce = await http
          .delete(
            Uri.parse(url),
          )
          .timeout(
            const Duration(seconds: 50),
          );

      jsonResponce = returnResponse(responce);

      if (responce.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException('');
    } on RequestTimeOutException {
      throw FetchDataException('Time out try again');
    }

    if(kDebugMode){
      print("Jason: $jsonResponce");
    }
    return jsonResponce;
  }

  dynamic returnResponse(http.Response responce) {
    if(kDebugMode){
      print(responce.statusCode);
    }
    switch (responce.statusCode) {
      case 200:
        dynamic jsonResponce = jsonDecode(responce.body);
        return jsonResponce;
      case 400:
        dynamic jsonResponce = jsonDecode(responce.body);
        return jsonResponce;
      case 401:
        return UnauthorizedException();
      case 500:
        return FetchDataException('Error communication with server${responce.statusCode}');
      default:
        throw UnauthorizedException();
    }
  }
}
