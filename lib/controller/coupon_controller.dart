import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/coupon_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';

class CouponController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  CouponViewmodel? couponDetails;

  var persistent = "";
  var customizedProductsFromCoupon = <OrderItemViewmodel>[].obs;
  removeItemFromCustomizedOrder(OrderItemViewmodel item) {
    customizedProductsFromCoupon
        .removeWhere((element) => element.product?.id == item.product?.id);
    customizedProductsFromCoupon.refresh();
  }

  addQtyToCustomizedItem(OrderItemViewmodel item) {
    var index = customizedProductsFromCoupon.value
        .indexWhere((element) => element.product?.id == item.product?.id);
    print("qty update index ${index}");
    if (index > -1) {
      customizedProductsFromCoupon[index].qty += 1;
      print("qty update ${customizedProductsFromCoupon[index].qty}");
      customizedProductsFromCoupon.refresh();
    }
  }

  removeQtyCustomizedItem(OrderItemViewmodel item) {
    var index = customizedProductsFromCoupon.value
        .indexWhere((element) => element.product?.id == item.product?.id);
    if (index > -1) {
      if (index > -1) {
        customizedProductsFromCoupon[index].qty -= 1;
        customizedProductsFromCoupon.refresh();
      }
    }
  }

  List<int> get customizedServicesIndexes {
    var indexes = <int>[];
    var servicesIdInsideCoupon =
        couponDetails?.services?.map((e) => e.service?.id).toList();
    for (var element in customizedProductsFromCoupon) {
      var i = servicesIdInsideCoupon?.indexOf(element.product?.service);
      if (i != null && i > -1) indexes.add(i);
    }
    return indexes;
  }

  getCouponDetails(String couponId, BuildContext context) async {
    try {
      //remove any exception
      _exception(AppException());
      _isDataLoading(true);

      persistent = "persisted screen";

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
