import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/usecase/business_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';

class BusinessController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  BusienssViewmodel? businessDetails;

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
}
