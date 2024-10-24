import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:api_assignment/Data/Models/Network_Response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    Uri uri = Uri.parse(url);
    final Response response = await get(uri);
    debugPrintResponse(url, response);
    try {
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeData);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic>? body) async {
    Uri uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Response response =
        await post(uri, body: jsonEncode(body), headers: headers);
    debugPrintResponse(url, response);
    dynamic decodeData = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeData);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> deleteRequest(String url) async {
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    debugPrintResponse(url, response);
    try {
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }


 static Future<NetworkResponse> updateRequest(
      String url, Map<String, dynamic>? body) async {
    Uri uri = Uri.parse(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    
    Response response = await post(uri, body: jsonEncode(body), headers: headers);
    debugPrintResponse(url, response);
    try {
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: response.body);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static void debugPrintResponse(String url, Response response) {
    debugPrint(
      'URL : $url\nRESPONSE CODE: ${response.statusCode}\nBODY : ${response.body}',
    );
  }
}
