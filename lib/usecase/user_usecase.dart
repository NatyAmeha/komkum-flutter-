import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/model/repo/shared_pref_repo.dart';

import 'package:komkum/model/user.dart';

import 'package:komkum/service/account_service.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/auth_result_viewmodel.dart';
import 'package:komkum/viewmodel/user_viewmodel.dart';

import '../model/notification.dart';

class UserUsecase {
  IRepositroy? userRepo;
  ISharedPrefRepository? sharedPrefRepo;
  IAccountService? accountService;

  UserUsecase({this.userRepo, this.accountService, this.sharedPrefRepo});

  Future<String?> sendVerificaationCode(String phoneNumber) async {
    try {
      var verificationId =
          await accountService!.sendVerificationCode(phoneNumber);
      return verificationId;
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool> verifySmsCode(String verificationId, String code) async {
    var result = await accountService!.verifyCode(verificationId, code);
    return result;
  }

  Future<User> registerOrAuthenticatewithPhone(User userInfo) async {
    var authResult = await userRepo!
        .create<AuthResultViewmodel, User>("/auth/user/signin", userInfo);
    if (authResult.token != null) {
      print("auth result data $authResult");
      var userResult = await accountService!.decodeToken(authResult.token!);
      var preferenceSaveResult =
          await sharedPrefRepo!.saveUserInfo(userResult, authResult.token!);
      return userResult;
    } else {
      return Future.error(
          AppException(message: "Unable to get authentication token"));
    }
  }

  Future<UserViewmodel?> getUserInfo() async {
    var userREsult = await userRepo!.get<UserViewmodel>("/user/account");
    return userREsult;
  }

  Future<UserViewmodel?> getUserFavoriteProducts() async {
    var productResult =
        await userRepo!.get<UserViewmodel>("/user/products/favorite");
    return productResult;
  }

  Future<UserViewmodel?> getUserFavoriteBusinesses() async {
    var productResult =
        await userRepo!.get<UserViewmodel>("/user/businesses/favorite");
    return productResult;
  }

  Future<UserViewmodel?> getUserOrders() async {
    var productResult = await userRepo!.get<UserViewmodel>("/order/user");
    return productResult;
  }

  Future<bool> registerFCMToken() async {
    try {
      var token = await accountService!.getFCMToken(null);
      var result = await userRepo!.update<bool, dynamic>("/user/fcmtoken/add",
          queryParameters: {"fcmtoken": token});
      return result;
    } catch (ex) {
      return false;
    }
  }

  Future<String?> sendVerificationCode(String phoneNumber) async {
    var result = await accountService!.sendVerificationCode(phoneNumber);
    return result;
  }

  Future<List<Notification>> getUserNotifications() async {
    var result = await userRepo!.getAll<Notification>("/notifications");
    var newNotification =
        result.where((element) => element.seen == false).toList();
    var oldNotifications =
        result.where((element) => element.seen == true).toList();
    var sortedREsult = [...newNotification, ...oldNotifications];
    return sortedREsult;
  }

  Future<bool> updateNotificationStatus(String notificationId) async {
    var result =
        await userRepo!.update<bool, dynamic>("/notification/$notificationId");
    return result;
  }

  Future<String?> getUserIdFromPref() async {
    var result = await sharedPrefRepo!.get<String>(Constants.USER_ID);
    return result;
  }

  Future<String?> getSavedToken() async {
    var result = await sharedPrefRepo!.get<String>(Constants.TOKEN);
    return result;
  }

  Future<User?> getUserInfoFromPref() async {
    var tokenResult = await getSavedToken();
    print("res $tokenResult");
    if (tokenResult != null) {
      var result = await accountService!.decodeToken(tokenResult);
      return result;
    } else {
      return null;
    }
  }
}
