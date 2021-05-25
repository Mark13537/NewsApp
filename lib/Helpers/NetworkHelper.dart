import 'dart:io';

import 'package:dio/dio.dart';

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
  } on SocketException catch (_) {
    return false;
  }
  return true;
}

Dio getDio() {
  Dio dio = new Dio();
  dio.options.followRedirects = false;
  dio.options.validateStatus = (status) {
    return status <= 500;
  };
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';
  dio.options.responseType = ResponseType.json;
  return dio;
}
