import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/model/order.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/order_usecase.dart';
import 'package:komkum/usecase/user_usecase.dart';
import 'package:komkum/utils/constants.dart';
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
  List<OrderViewmodel>? get purchases => orderLists
      ?.where((element) => element.order?.type == OrderType.PURCHASE.name)
      .toList();

  List<OrderViewmodel>? get bookings => orderLists
      ?.where((element) => element.order?.type == OrderType.BOOKING.name)
      .toList();

  getOrderDetails(String orderId, BuildContext context) async {
    try {
      //remove any exception
      orderDetails = null;
      _exception(AppException());
      _isDataLoading(true);

      var orderUsecase = OrderUsecase(orderRepo: ApiRepository());
      orderDetails = await orderUsecase.getOrderDetails(orderId);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getOrderDetails(orderId, context);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  getUserOrders(BuildContext context) async {
    try {
      _isDataLoading(true);
      orderLists = null;
      var userUsecase = UserUsecase(userRepo: ApiRepository());

      var userResult = await userUsecase.getUserOrders();
      orderLists = userResult?.orders;
    } catch (ex) {
      print("error ${ex.toString()}");
      var appException = AppException(action: () {
        _exception(AppException());
        getUserOrders(context);
      });

      _exception(UIHelper.handleException(appException, context));
    } finally {
      _isDataLoading(false);
    }
  }
}
