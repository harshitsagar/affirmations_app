// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:affirmations_app/app/data/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

class APIProvider {
  late Dio _dio;

  APIProvider() {
    _dio = Dio();
  }

  Future<Response<dynamic>> getAPICall(
    String url, {
    Map<String, dynamic>? header,
  }) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header $header");
    final Response<dynamic> response = await _dio.get(
      uri,
      options: Options(
        headers: header,
      ),
    );
    throwIfNoSuccess(response);
    log("response $response");
    if (response.data is Map &&
        response.data["code"] != null &&
        int.parse(response.data["code"]) == 401) {
      // flutterSecureStorage.deleteAll();
    }
    return response;
  }

  Future<Response<dynamic>> secondGetAPICall(
    String url,
    Map<String, dynamic>? header,
  ) async {
    String uri = Config.baseUrl + url;
    log("uri  $uri");
    log("header $header");
    final Response<dynamic> response = await _dio.get(
      url,
      options: Options(
        headers: header,
      ),
    );
    throwIfNoSuccess(response);
    log("response $response");
    if (response.data["code"] == 401) {
      // flutterSecureStorage.deleteAll();
    }
    return response;
  }

  Future<Response<dynamic>> getAPICallWithQueryParam(
    String url,
    dynamic data,
    Map<String, dynamic>? header,
  ) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header $header");
    final Response<dynamic> response = await _dio.get(
      uri,
      queryParameters: data as Map<String, dynamic>,
      options: Options(
        headers: header,
      ),
    );
    throwIfNoSuccess(response);
    log("response $response");
    if (response.data["code"] == 401) {
      // flutterSecureStorage.deleteAll();
    }
    return response;
  }

  Future<Response<dynamic>> postAPICall(
    String url,
    dynamic data,
    Map<String, dynamic>? header,
  ) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header  $header");
    log("body $data");
    Response<dynamic> response = await _dio.post(
      uri,
      data: jsonEncode(
        data,
      ),
      options: Options(
        headers: header,
      ),
    );
    throwIfNoSuccess(response);
    log("response $response");
    if (response.data["code"] == 401) {
      // flutterSecureStorage.deleteAll();
    }
    return response;
  }

  Future<Response<dynamic>> postAPICallWithOutParameter(
    String url,
    Map<String, dynamic>? header,
  ) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header $header");
    Response<dynamic> response = await _dio.post(
      uri,
      options: Options(
        headers: header,
      ),
    );
    throwIfNoSuccess(response);
    log("response $response");
    if (response.data["code"] == 401) {
      // flutterSecureStorage.deleteAll();
    }
    return response;
  }

  Future<Response<dynamic>> deleteAPICall(
    String url,
    Map<String, dynamic>? header,
  ) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header $header");
    final Response<dynamic> response = await _dio.delete(
      uri,
      options: Options(
        headers: header,
      ),
    );
    throwIfNoSuccess(response);
    log("response $response");
    if (response.data["code"] == 401) {
      // flutterSecureStorage.deleteAll();
    }
    return response;
  }

  Future<Response<dynamic>> putAPICall(
    String url,
    dynamic data,
    Map<String, dynamic>? header,
  ) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header $header");
    final Response<dynamic> response = await _dio.put(
      uri,
      data: data,
      options: Options(
        headers: header,
      ),
    );
    throwIfNoSuccess(response);
    log("response $response");
    if (response.data["code"] == 401) {
      // flutterSecureStorage.deleteAll();
    }
    return response;
  }

  Future formDataPostAPICall(
    String url,
    Map<String, dynamic> data,
    Map<String, String>? header, {
    File? picture,
  }) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header $header");
    log("body $data");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        uri,
      ),
    );
    request.headers.addAll(
      header!,
    );
    request.fields.addAll(
      {
        'data': jsonEncode(
          data,
        ),
      },
    );
    if (picture != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'picture',
          picture.path,
        ),
      );
    }

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var resDecode = jsonDecode(
      res,
    );

    log("Response $resDecode");
    return resDecode;
  }

  multipleFormDataPostAPICall(
    String url,
    Map<String, dynamic> data,
    Map<String, String>? header, {
    List<File?>? picture,
  }) async {
    String uri = Config.baseUrl + url;
    log("uri $uri");
    log("header  $header");
    log("body  $data");

    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(header!);
    request.fields.addAll({'data': jsonEncode(data)});
    if (picture?[0] != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image1', picture![0]!.path));
    }
    if (picture?[1] != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image2', picture![1]!.path));
    }
    if (picture?[2] != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image3', picture![2]!.path));
    }
    if (picture?[3] != null) {
      request.files.add(
          await http.MultipartFile.fromPath('document1', picture![3]!.path));
    }
    if (picture?[4] != null) {
      request.files.add(
          await http.MultipartFile.fromPath('document2', picture![4]!.path));
    }
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var resDecode = jsonDecode(res);

    log("Response $resDecode");
    // if (resDecode.code == 401) {
    //   // flutterSecureStorage.deleteAll();
    // }
    return resDecode;
  }

  void throwIfNoSuccess(response) {
    log("Response statusCode ${response.statusCode}");
    if (response.statusCode! < 200 || response.statusCode! > 299) {
      throw HttpException(response);
    }
  }

  void throwIfNoSuccessInMultipart(response) {
    log("Response statusCode ${response["code"]}");
    if (response["code"]! > 100 || response["code"]! >= 500) {
      if (kDebugMode) {
        print(
          response["code"],
        );
      }
      throw HttpException(response);
    }
  }
}

class HttpException implements Exception {
  HttpException(this.response);

  Response<dynamic> response;
}

String handleDioError(Object? error) {
  if (error is DioError) {
    if (error.response?.statusCode == 401) {
      //  FlutterSecureStorageHelper.deleteAll();
    } else if (error.response?.statusCode == 400) {
      return "Error in Register With statusCode ${error.response?.statusCode}";
    } else {
      return "Something went wrong!";
    }
  }
  return error.toString();
}
