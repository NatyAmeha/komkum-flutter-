import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/service_usecase.dart';
import 'package:komkum/usecase/user_usecase.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/order_summary_screen.dart';
import 'package:komkum/view/screen/product_list_screen.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class ProductController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  ProductViewmodel? productDetail;
  var isProductInFavorite = false.obs;

  List<ProductViewmodel>? productLists;

  var selectedVariantIndex = 0.obs;
  var selectedQty = 1.obs;
  ProductVariant? selectedProductVariant;

  int? get finalProductPrice =>
      (selectedProductVariant?.fixedPrice ??
          productDetail?.serviceItem!.fixedPrice ??
          productDetail?.serviceItem?.minPrice ??
          0) *
      selectedQty.value;

  Coupon? get selectedCouponForProduct {
    productDetail?.couponsInfo?.sort((a, b) =>
        (a.couponInfo?.discountAmount ?? 10)
            .compareTo(b.couponInfo?.discountAmount ?? 0));
    return productDetail?.couponsInfo?.first?.couponInfo;
  }

  changeSelectedVariant(int index) {
    selectedProductVariant = productDetail?.serviceItem?.variants![index];

    selectedVariantIndex(index);
    // to refresh the price when product variant changed by user
    selectedQty.refresh();
  }

  addQty() {
    selectedQty.value += 1;
  }

  remvoeQty() {
    if (selectedQty.value > 1) selectedQty.value -= 1;
  }

  getProductDetails(String productId, BuildContext context) async {
    try {
      //remove any exception

      if (productId == productDetail?.serviceInfo?.id) {
        return null;
      }
      productDetail = null;
      selectedQty(1);
      selectedProductVariant = null;
      _exception(AppException());
      _isDataLoading(true);
      var serviceUsecase = ServiceUsecase(serviceRepo: ApiRepository());
      productDetail = await serviceUsecase.getProductInfo(productId);
      isProductInFavorite(productDetail?.favorite);
      if (productDetail?.serviceItem?.variants?.isNotEmpty == true) {
        changeSelectedVariant(0);
      }
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

  getUserFavoriteProducts(BuildContext context) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(userRepo: ApiRepository());

      var userResult = await userUsecase.getUserFavoriteProducts();
      productLists = userResult?.favoriteProducts;
      if (productLists?.isEmpty == true) {
        var appException = AppException(
          message:
              "Click the heart icon on the product page and your favorite products will appear here",
          title: "No product found",
          actionText: "Browse products",
        );

        _exception(appException);
      }
    } catch (ex) {
      print("exception ${ex.toString()}");
      var appException = AppException(
          message: "Sign in to continue to the app",
          title: "Sign in",
          actionText: "Sign in",
          action: () {
            UIHelper.moveToLoginOrRegister(context,
                redirectTo: ProductListScreen.routeName);
          });
      _exception(appException);
    } finally {
      _isDataLoading(false);
    }
  }

  addProductToFavorite(List<String> productIds, BuildContext context) async {
    try {
      //remove any exception

      _isDataLoading(true);
      var serviceUsecase = ServiceUsecase(serviceRepo: ApiRepository());
      var result = await serviceUsecase.addProductToFavorite(productIds);
      isProductInFavorite(result);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      UIHelper.showToast(context, "Unable to add to favorite");
    } finally {
      _isDataLoading(false);
    }
  }

  removeProductFromFavorite(
      List<String> productIds, BuildContext context) async {
    try {
      //remove any exception

      _isDataLoading(true);
      var serviceUsecase = ServiceUsecase(serviceRepo: ApiRepository());
      var result = await serviceUsecase.removeProductFromFavorite(productIds);
      isProductInFavorite(!result);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      UIHelper.showToast(context, "Unable to remove from favorite");
    } finally {
      _isDataLoading(false);
    }
  }

  generateOrderSummary(BuildContext context, ProductViewmodel productInfo,
      {String? callToAction}) {
    var itemName = productInfo.serviceItem?.name;
    var image = selectedProductVariant?.images?.first ??
        productInfo.serviceItem?.images?.first;
    if (selectedProductVariant != null) {
      itemName =
          "${productInfo.serviceItem?.name}, ${selectedProductVariant?.moreInfo?.values.join(",")}";
    }
    var orderInfo = OrderItemViewmodel(
        name: itemName,
        image: image,
        product: productInfo.serviceItem,
        business: productInfo.businessInfo,
        service: productInfo.serviceInfo,
        qty: selectedQty.value,
        coupon: selectedCouponForProduct,
        price: ((finalProductPrice ?? 0) ~/ selectedQty.value).toInt());

    appController.addToCart(orderInfo);
    _isDataLoading(false);

    UIHelper.goToScreen(context, OrderSummaryScreen.routeName, extra: {
      "CALLTOACTION": callToAction,
    });
  }
}
