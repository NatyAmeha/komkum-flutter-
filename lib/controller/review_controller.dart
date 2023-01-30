import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/usecase/review_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/review_viewmodel.dart';

class ReviewController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  ReviewViewmodel? reviewData;

  var selectedKeyReviewPointIndex = 0.obs;
  List<Review>? allReviews;

  getBusinessReviewInfo(String businessId, BuildContext context,
      {String? keyPoint}) async {
    try {
      //remove any exception
      reviewData = null;
      selectedKeyReviewPointIndex(0);

      _exception(AppException());
      _isDataLoading(true);

      var serviceUsecase = ReviewUsecase(reviewRepo: ApiRepository());
      reviewData =
          await serviceUsecase.getBusinessReview(businessId, key: keyPoint);
      if (keyPoint == null || keyPoint == "All") {
        allReviews = reviewData?.reviews;
      }
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getBusinessReviewInfo(businessId, context, keyPoint: keyPoint);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  getServcieReviewInfo(String serviceId, BuildContext context,
      {String? keyPoint}) async {
    try {
      //remove any exception
      reviewData = null;
      selectedKeyReviewPointIndex(0);
      _exception(AppException());
      _isDataLoading(true);

      var serviceUsecase = ReviewUsecase(reviewRepo: ApiRepository());
      reviewData =
          await serviceUsecase.getServiceReview(serviceId, key: keyPoint);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getBusinessReviewInfo(serviceId, context, keyPoint: keyPoint);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }
}
