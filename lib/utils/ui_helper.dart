import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:komkum/model/repo/shared_pref_repo.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/view/page/error_page.dart';
import 'package:komkum/view/screen/login_screen.dart';
import 'package:komkum/view/screen/register_screen.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/loading_progressbar.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

import '../model/order.dart';

class UIHelper {
  static const mainNavigatorKeyId = 10;
  static const bottomNavigatorKeyId = 11;

  static showToast(BuildContext context, String message,
      {Toast length = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey[700],
        // textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget displayContent({
    required Widget content,
    required bool showWhen,
    required AppException exception,
    bool isDataLoading = true,
    Widget? loadingWidget,
  }) {
    if (!showWhen && exception.message != null) {
      return ErrorPage(exception: exception);
    } else {
      return Stack(
        children: [
          if (showWhen) content,
          if (isDataLoading)
            showWhen
                ? LoadingProgressbar(loadingState: isDataLoading)
                : loadingWidget ??
                    LoadingProgressbar(loadingState: isDataLoading)
        ],
      );
    }

    // else {
    //   return content;
    // }
  }

  static goToScreen(BuildContext context, String location,
      {Map<String, dynamic>? queryParam,
      Object? extra,
      bool resetBackstack = false}) {
    String destination = location;

    if (resetBackstack) {
      context.go(location, extra: extra);
    } else {
      context.push(location, extra: extra);
    }
  }

  static moveToLoginOrRegister(BuildContext context,
      {String? redirectTo}) async {
    var repo = SharedPreferenceRepository();
    var isPreviouslyRegistered = await repo.get<bool>(Constants.REGISTERED);
    if (isPreviouslyRegistered == true) {
      goToScreen(context, "${LoginScreen.routeName}?redirect=$redirectTo");
      // moveToScreen(LoginScreen.routeName);
    } else {
      goToScreen(
          context, "${RegistrationScreen.routeName}?redirect=$redirectTo");
      // moveToScreen(RegistrationScreen.routeName);
    }
  }

  static goBack(BuildContext context) {
    context.pop();
  }

  static handleException(AppException exception, BuildContext context,
      {String? message, String? redirectTo}) {
    if (exception.type == AppException.UNAUTORIZED_EXCEPTION) {
      UIHelper.moveToLoginOrRegister(context, redirectTo: redirectTo);
    } else if (exception.type == AppException.BAD_REQUEST_EXCEPTION) {
      UIHelper.showToast(
          context, "${exception.message} went wrong, please try again");
    } else if (exception.type == AppException.PERMISSION_DENIED_EXCEPTION) {}
  }

  static showBottomSheetDialog(BuildContext context,
      {Widget? title, required Widget body}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => body,
    );
  }

  static PriceRange getServicePriceRange(ServiceViewmodel serviceInfo) {
    var priceRanges = [];
    serviceInfo.serviceItems?.forEach(
      (product) {
        if (product.fixedPrice != null) {
          priceRanges.add(product.fixedPrice);
        } else {
          priceRanges.addAll([product.minPrice!, product.maxPrice]);
        }
      },
    );
    priceRanges.sort();
    return PriceRange(min: priceRanges.first, max: priceRanges.last);
  }

  static Widget showPrice(BuildContext context,
      {int? fixedPrice, int? minPrice, int? maxPrice, int discountAmount = 0}) {
    if (fixedPrice != null) {
      if (discountAmount > 0) {
        var discountedPrice = fixedPrice - (fixedPrice * discountAmount) ~/ 100;
        return Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "$fixedPrice Birr\n",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(
                text: "$discountedPrice Birr",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      } else {
        return CustomText(
          "$fixedPrice Birr",
          textStyle: Theme.of(context).textTheme.titleMedium,
          fontWeight: FontWeight.bold,
        );
      }
    } else {
      if (discountAmount > 0) {
        var discountedMin = minPrice! - (minPrice * discountAmount) ~/ 100;
        var discountedMax = maxPrice! - (maxPrice * discountAmount) ~/ 100;
        return Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "$minPrice Birr - $maxPrice Birr\n",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(
                text: "$discountedMin Birr - $discountedMax Birr",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      } else {
        return CustomText(
          "$minPrice Birr - $maxPrice Birr",
          textStyle: Theme.of(context).textTheme.titleMedium,
          fontWeight: FontWeight.bold,
        );
      }
    }
  }
}
