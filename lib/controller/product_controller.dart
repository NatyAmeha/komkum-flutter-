import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/service_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class ProductController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  ProductViewmodel? productDetail;

  getProductDetails(String productId, BuildContext context) async {
    try {
      //remove any exception
      if (productId != productDetail?.serviceInfo?.id) {
        productDetail = null;
      }
      _exception(AppException());
      _isDataLoading(true);
      var serviceUsecase = ServiceUsecase(serviceRepo: ApiRepository());
      productDetail = await serviceUsecase.getProductInfo(productId);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getProductDetails(productId, context);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }
}
