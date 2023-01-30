import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:komkum/model/user.dart' as AppUser;
import 'package:komkum/service/jwt_decoder.dart';
import 'package:komkum/utils/exception.dart';

abstract class IAccountService {
  Future<String?> sendVerificationCode(String phoneNumber);
  Future<bool> verifyCode(String verificationId, String code);
  Future<AppUser.User> decodeToken(String token);
  Future<String?> getFCMToken(String? vapidKey);
}

class FirebaseAuthService implements IAccountService {
  IJWTDecoder jwtDecocer;
  FirebaseAuthService({this.jwtDecocer = const JwtDecoder()});
  var firebaseAuthInstance = FirebaseAuth.instance;
  @override
  Future<String?> sendVerificationCode(String phoneNumber) async {
    //converting callback to future based api
    var completer = Completer<String?>();
    try {
      await firebaseAuthInstance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (a) {
            print("verification completed ${a.toString()}");
            completer.complete(null);
          },
          verificationFailed: (ex) {
            if (ex.code == "invalid-phone-number") {
              completer.completeError(AppException(
                  type: AppException.INVALID_PHONE_NUMBER_EXCEPTION,
                  message: ex.message));
            }
            print("veriication failed , ${ex.message}");
          },
          codeSent: (verificationId, resendToken) {
            print("code sent to device  ${verificationId.toString()}");

            completer.complete(verificationId);
          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (valverificationId) {});
    } catch (ex) {
      print("auth error ${ex.toString()}");
      completer.completeError(AppException(
          type: AppException.UNKNOWN_EXCEPTION, message: ex.toString()));
    }
    return completer.future;
  }

  @override
  Future<bool> verifyCode(String verificationId, String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    var authResult =
        await firebaseAuthInstance.signInWithCredential(credential);
    if (authResult.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<AppUser.User> decodeToken(String token) async {
    var result = jwtDecocer.decodeToken(token);
    var userResult = AppUser.User(
      id: result["id"],
      username: result["username"],
      phoneNumber: result["phoneNumber"],
      profileImage: result["profileImage"],
    );
    return userResult;
  }

  @override
  Future<String?> getFCMToken(String? vapidKey) async {
    var result = await FirebaseMessaging.instance.getToken();
    return result;
  }
}
