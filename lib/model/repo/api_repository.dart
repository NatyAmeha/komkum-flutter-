import 'package:dio/dio.dart';
import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/extension.dart';

import 'api_client.dart';

class ApiRepository<T> implements IRepositroy<T> {
  ApiRepository();
  final dioClient = ApiClient.getDioInstance();
  @override
  Future<R> create<R, S>(String path, S body,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var finalResult;
      var result = await dioClient.post(path,
          data: body, queryParameters: queryParameters);
      if (R.toString() == "String" || R.toString() == "bool") {
        finalResult = result.data;
      } else {
        var mapResult = result.data as Map<String, dynamic>;
        finalResult = mapResult.toObject(R.toString());
      }
      return finalResult as R;
    } on DioError catch (ex) {
      print(ex);
      return Future.error(AppException.handleerror(ex));
    }
  }

  @override
  Future<bool> delete(String path, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<R?> get<R>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var result = await dioClient.get(path, queryParameters: queryParameters);
      print("api result $result");
      var mapResult = result.data as Map<String, dynamic>;
      var finalResult = await mapResult.toObject(R.toString());
      return finalResult as R?;
    } on DioError catch (ex) {
      print(ex.toString());
      return Future.error(AppException.handleerror(ex));
    }
  }

  @override
  Future<List<R>> getAll<R>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      // var result =  apiClient.get(path)
      var response =
          await dioClient.get(path, queryParameters: queryParameters);
      var conversionResult = response.data as List<dynamic>;
      var finalResult = conversionResult.map((element) {
        var newElement = element as Map<String, dynamic>;
        return newElement.toObject(R.toString()) as R;
      }).toList();
      print(finalResult);

      return finalResult;
    } on DioError catch (e) {
      print(e);
      return Future.error(AppException.handleerror(e));
    }
  }

  @override
  Future<R> update<R, S>(String path,
      {S? body, Map<String, dynamic>? queryParameters}) async {
    try {
      var result = await dioClient.put(path,
          data: body, queryParameters: queryParameters);
      print("resut ${result.data}");

      var mapResult = result.data as R;
      // var finalResult = await mapResult.toObject(S.toString());
      return mapResult;
    } on DioError catch (ex) {
      print(ex.toString());
      return Future.error(AppException.handleerror(ex));
    }
  }
}
