import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/model/repo/shared_pref_repo.dart';
import 'package:komkum/model/user.dart';
import 'package:komkum/service/account_service.dart';
import 'package:komkum/usecase/user_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/page/account_page.dart';
import 'package:komkum/view/screen/home_screen.dart';
import 'package:komkum/view/screen/verification_screen.dart';
import 'package:komkum/viewmodel/user_viewmodel.dart';

class UserController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = false.obs;
  bool get isDataLoading => _isDataLoading.value;
  changeDataloading(bool load) {
    _isDataLoading(load);
  }

  var showAppbarTitle = false.obs;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  UserViewmodel? userGeneralINfo;

  String? redirectUrl;

  User? userInfo;

  sendCode(BuildContext context, bool isPreviouslyLoggedIn) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
          userRepo: ApiRepository<User>(),
          accountService: FirebaseAuthService());

      var verificationidResult =
          await userUsecase.sendVerificationCode(userInfo!.phoneNumber!);
      _isDataLoading(false);
      if (verificationidResult != null) {
        // phone is not auto verified
        print("code sent ${verificationidResult}");
        UIHelper.goToScreen(
          context,
          VerificationScreen.routeName,
          extra: {
            "verificationId": verificationidResult,
            "isLoggedinBefore": isPreviouslyLoggedIn
          },
        );
        print("route variables called after navigation");
      } else {
        // phone is auto verified
        _isDataLoading(true);
        var isAuthenticated = await signupWithPhone(true);
        if (isAuthenticated) {
          UIHelper.goToScreen(context, HomeScreen.routeName);
        } else {
          UIHelper.showToast(
              context, "Unable to authenticate this phone number.");
        }
      }
    } catch (ex) {
      print(ex.toString());
      UIHelper.showToast(context, "Unable to send verificatin code");
      // _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  verifySmsCode(BuildContext context, String verificationId,
      String submittedCode, bool isPreviouslyLoggedIn) async {
    try {
      _isDataLoading(true);

      // compare the above code and check verification using firebase auth
      var userUsecase = UserUsecase(
          userRepo: ApiRepository<User>(),
          accountService: FirebaseAuthService());
      var verificationResult =
          await userUsecase.verifySmsCode(verificationId, submittedCode);
      print("firebase result $verificationResult");

      if (verificationResult) {
        var isAuthenticated = await signupWithPhone(true);
        if (isAuthenticated) {
          print("redirect called $redirectUrl");
          if (redirectUrl != null) {
            UIHelper.goToScreen(context, redirectUrl!, resetBackstack: true);
          } else {
            UIHelper.goToScreen(context, HomeScreen.routeName,
                resetBackstack: false);
          }
        } else {
          UIHelper.showToast(
              context, "Error occured, unable to authenticate your phone");
        }
      } else {
        UIHelper.showToast(context, "Input is not correct");
      }
    } catch (ex) {
      print("firebase error ${ex.toString()}");
      UIHelper.showToast(context,
          "Unable to verify your phone number. Check your input and try again.");
    } finally {
      _isDataLoading(false);
    }
  }

  Future<bool> signupWithPhone(bool isPreviouslyLOggedin) async {
    // _exception(AppException());

    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
          userRepo: ApiRepository<User>(),
          accountService: FirebaseAuthService(),
          sharedPrefRepo: SharedPreferenceRepository());
      var userResult =
          await userUsecase.registerOrAuthenticatewithPhone(userInfo!);

      // var tokenSaveResult = await userUsecase.registerFCMToken();
      print("token save result ${userResult.id}");
      appController.loggedInUser(userResult);
      return true;
    } catch (ex) {
      print("auth error ${ex.toString()}");
      rethrow;
    } finally {
      _isDataLoading(false);
    }
  }

  getUserInfo(BuildContext context) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
        userRepo: ApiRepository<User>(),
        accountService: FirebaseAuthService(),
      );

      userGeneralINfo = await userUsecase.getUserInfo();
    } catch (ex) {
      var appException = AppException(
          message: "Sign in to continue to the app",
          title: "Sign in",
          actionText: "Sign in",
          action: () {
            UIHelper.moveToLoginOrRegister(context,
                redirectTo: HomeScreen.routeName);
          });
      _exception(appException);
    } finally {
      _isDataLoading(false);
    }
  }

  logout(BuildContext context) async {
    userGeneralINfo = null;
    appController.logout();
    UIHelper.moveToLoginOrRegister(context, redirectTo: AccountPage.routeName);
  }
}
