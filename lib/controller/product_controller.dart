import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/service_usecase.dart';
import 'package:komkum/usecase/user_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/product_list_screen.dart';
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
      isProductInFavorite(productDetail?.favorite);
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
}
