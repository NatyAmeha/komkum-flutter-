import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/service_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/order_summary_screen.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';
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

  Coupon? get selectedCoupon {
    var coupons = serviceDetails?.coupons;
    if (coupons?.isNotEmpty == true) {
      coupons!.sort((a, b) => b.couponInfo!.discountAmount!
          .compareTo(a.couponInfo!.discountAmount!));
      return coupons.first.couponInfo;
    }
    return null;
  }

  int? get finalProductPrice =>
      (selectedProductVariant?.fixedPrice ??
          selectedProductDetail?.serviceItem!.fixedPrice ??
          selectedProductDetail?.serviceItem?.minPrice ??
          0) *
      selectedQty.value;

  var selectedVariantIndex = (-1).obs;
  var selectedQty = 1.obs;

  changeSelectedVariant(String productId, int index) {
    if (selectedProductDetail != null &&
        selectedProductDetail?.serviceItem?.variants?.isNotEmpty == true) {
      selectedProductVariant =
          selectedProductDetail!.serviceItem!.variants![index];
      selectedVariantIndex(index);
      // selectedQty.refresh();
    }
  }

  getSelectedProducdtDetails(Product simpleProductINfo) {
    var fullProdutInfo = ProductViewmodel(
        serviceItem: simpleProductINfo,
        businessInfo: serviceDetails?.business?.businessInfo,
        serviceInfo: serviceDetails?.service);
    selectedProductDetail = fullProdutInfo;
  }

  addQty() {
    selectedQty.value += 1;
  }

  remvoeQty() {
    if (selectedQty.value > 1) selectedQty.value -= 1;
  }

  ProductVariant? selectedProductVariant;

  ProductViewmodel? selectedProductDetail;

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
      selectedVariantIndex(-1);

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

  OrderItemViewmodel generateOrderSummary(
    BuildContext context, {
    String? callToAction,
  }) {
    var itemName = selectedProductDetail?.serviceItem?.name;
    var image = selectedProductVariant?.images?.first ??
        selectedProductDetail?.serviceItem?.images?.first;
    if (selectedProductVariant != null) {
      itemName =
          "${selectedProductDetail?.serviceItem?.name}, ${selectedProductVariant?.moreInfo?.values.join(",")}";
    }
    var orderInfo = OrderItemViewmodel(
        name: itemName,
        image: image,
        product: selectedProductDetail?.serviceItem,
        business: selectedProductDetail?.businessInfo ??
            Business(id: selectedProductDetail?.serviceItem?.business),
        service: selectedProductDetail?.serviceInfo,
        qty: selectedQty.value,
        coupon: selectedCoupon,
        price: ((finalProductPrice ?? 0) ~/ selectedQty.value).toInt());

    appController.addToCart(orderInfo);
    _isDataLoading(false);

    return orderInfo;
  }
}
