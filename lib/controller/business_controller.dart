import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/business_usecase.dart';
import 'package:komkum/usecase/user_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/business_list_screen.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';

class BusinessController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  BusienssViewmodel? businessDetails;
  List<BusienssViewmodel>? businessLists;

  var isBusinessInFavorite = false.obs;

  getBusinessDetails(String businessId, BuildContext context) async {
    try {
      //remove any exception
      if (businessId == businessDetails?.businessInfo?.id) {
        return;
      } else {
        businessDetails = null;
      }
      _exception(AppException());
      _isDataLoading(true);
      if (businessId != businessDetails?.businessInfo?.id) {
        businessDetails = null;
      }
      var serviceUsecase = BusinessUsecase(businessRepo: ApiRepository());
      businessDetails = await serviceUsecase.getBusinessDetails(businessId);
      isBusinessInFavorite(businessDetails?.favorite ?? false);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getBusinessDetails(businessId, context);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  getUserFavoriteBusinesses(BuildContext context) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(userRepo: ApiRepository());

      var userResult = await userUsecase.getUserFavoriteBusinesses();
      businessLists = userResult?.favoriteBusinesses;
      if (businessLists?.isEmpty == true) {
        var appException = AppException(
          message:
              "Click the heart icon on the business detail screen and your favorite businesses will appear here",
          title: "No favorite business found",
          actionText: "Browse businesses",
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
                redirectTo: BusinessListScreen.routeName);
          });
      _exception(appException);
    } finally {
      _isDataLoading(false);
    }
  }

  addBusinessToFavorite(String businessId, BuildContext context) async {
    try {
      //remove any exception
      _isDataLoading(true);
      var businessUsecase = BusinessUsecase(businessRepo: ApiRepository());
      var result = await businessUsecase.addBusinessToFavorite(businessId);
      isBusinessInFavorite(result);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      UIHelper.showToast(context, "Unable to add to favorite");
    } finally {
      _isDataLoading(false);
    }
  }

  removeBusinessFromFavorite(String businessId, BuildContext context) async {
    try {
      //remove any exception

      _isDataLoading(true);
      var businessUsecase = BusinessUsecase(businessRepo: ApiRepository());
      var result = await businessUsecase.removeBusinessFromFavorite(businessId);
      isBusinessInFavorite(!result);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      UIHelper.showToast(context, "Unable to remove from favorite");
    } finally {
      _isDataLoading(false);
    }
  }
}
