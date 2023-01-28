import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/coupon_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

class CouponController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  CouponViewmodel? couponDetails;

  getCouponDetails(String couponId, BuildContext context) async {
    try {
      //remove any exception
      _exception(AppException());
      _isDataLoading(true);

      couponDetails = null;

      var serviceUsecase = CouponUsecase(couponRepo: ApiRepository());
      couponDetails = await serviceUsecase.getCouponDetails(couponId);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getCouponDetails(couponId, context);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }
}
