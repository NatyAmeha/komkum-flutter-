import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class ApiClient {
  static Dio? _dioClient;

  static Dio getDioInstance() {
    if (_dioClient != null) {
      // http://api.komkum.com
      return _dioClient!;
    } else {
      var dioOption = BaseOptions(
        baseUrl: "http://192.168.1.3:3000",
        connectTimeout: 30000,
        receiveTimeout: 30000,
        sendTimeout: 30000,
        responseType: ResponseType.json,
        contentType: ContentType.json.toString(),
      );
      _dioClient = Dio(dioOption);
      addAuthorizationInterceptor();
      return _dioClient!;
    }
  }

  static void addAuthorizationInterceptor() {
    _dioClient!.interceptors.clear();
    _dioClient!.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // var pref = SharedPreferenceRepository<String>();
      var pr = await SharedPreferences.getInstance();
      var tokenResult = pr.getString(Constants.TOKEN);
      if (tokenResult != null) {
        // var b = tokenResult.replaceAllMapped("", (match) => null);
        var a = 'Bearer $tokenResult';
        print("auth interceptor $a");
        options.headers[HttpHeaders.authorizationHeader] = a;
        // options.headers["Accept"] = "*/*";
      }
      return handler.next(options); //modify your request
    }));
  }
}
