import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/user_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/order_list_screen.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';

class Ordercontroller extends GetxController {
  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  OrderViewmodel? orderDetails;
  List<OrderViewmodel>? orderLists;

  var isBusinessInFavorite = false.obs;

  getUserOrders(BuildContext context) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(userRepo: ApiRepository());

      var userResult = await userUsecase.getUserOrders();
      orderLists = userResult?.orders;
      if (orderLists?.isEmpty == true) {
        var appException = AppException(
          message:
              "Click the heart icon on the business detail screen and your favorite businesses will appear here",
          title: "No order found",
          actionText: "Browse products and services",
        );

        _exception(appException);
      }
    } catch (ex) {
      // var appException = AppException(
      //     message: "Sign in to continue to the app",
      //     title: "Sign in",
      //     actionText: "Sign in",
      //     action: () {
      //       UIHelper.moveToLoginOrRegister(context,
      //           redirectTo: OrderListScreen.routeName);
      //     });
      UIHelper.handleException(ex as AppException, context);
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }
}
