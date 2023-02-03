import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/service_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class ServiceController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  ServiceViewmodel? serviceDetails;
  List<String?> get serviceProductCategories =>
      serviceDetails?.serviceItems
          ?.map((e) => e.category)
          .where((element) => element != null)
          .toList() ??
      [];

  int get discountAmount {
    var coupons = serviceDetails?.coupons;
    if (coupons?.isNotEmpty == true) {
      coupons!.sort((a, b) => b.couponInfo!.discountAmount!
          .compareTo(a.couponInfo!.discountAmount!));
      return coupons.first.couponInfo?.discountAmount ?? 0;
    }
    return 0;
  }

  var selectedVariantIndex = (-1).obs;
  var selectedQty = 1.obs;

  changeSelectedVariant(String productId, int index) {
    var selectedProduct = serviceDetails?.serviceItems
        ?.firstWhere((element) => element.id == productId);

    if (selectedProduct != null) {
      selectedVariant = selectedProduct.variants![index];
    }
    selectedVariantIndex(index);
  }

  addQty() {
    selectedQty.value += 1;
  }

  remvoeQty() {
    if (selectedQty.value > 1) selectedQty.value -= 1;
  }

  ProductVariant? selectedVariant;

  ProductViewmodel? productDetail;

  @override
  void onInit() {
    print("service controller called");
    super.onInit();
  }

  getServiceDetails(String serviceId, BuildContext context) async {
    try {
      //remove any exception
      // serviceDetails = null;
      if (serviceId == serviceDetails?.service?.id) {
        return;
      } else {
        serviceDetails = null;
      }
      _exception(AppException());
      _isDataLoading(true);
      var serviceUsecase = ServiceUsecase(serviceRepo: ApiRepository());
      var result = await serviceUsecase.getServiceDetail(serviceId);
      serviceDetails = result;
      selectedQty(1);
      selectedVariantIndex(0);

      print("controller result is ${serviceDetails?.service?.name}");
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getServiceDetails(serviceId, context);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }
}
