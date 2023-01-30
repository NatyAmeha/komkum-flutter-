import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:komkum/controller/user_controller.dart';

import 'package:komkum/model/user.dart' as AppUser;
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/loading_progressbar.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  String? redirectRoute;
  LoginScreen({this.redirectRoute});

  var phoneNumberController = TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userController = Get.put(UserController());
  String completePhoneNumber = "";

  @override
  Widget build(BuildContext context) {
    userController.redirectUrl = widget.redirectRoute;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            UIHelper.goBack(context);
          },
        ),
        title: CustomText("Login"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                CustomImage(
                  "assets/images/app_icon_foreground.png",
                  srcLocation: "assets",
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 16),
                CustomText(
                  "Sign in with phone number",
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                IntlPhoneField(
                  autofocus: false,
                  disableLengthCheck: true,
                  controller: widget.phoneNumberController,
                  decoration: const InputDecoration(
                    // fillColor: Colors.grey,
                    labelText: "Phone number",
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                  initialCountryCode: 'ET',
                  onChanged: (phone) {
                    completePhoneNumber = phone.completeNumber;
                  },
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Obx(
                    () => CustomButton(
                      "Login",
                      enabled: !userController.isDataLoading &&
                          completePhoneNumber.length >= 10,
                      onPressed: () async {
                        var user = AppUser.User(
                          phoneNumber: completePhoneNumber,
                        );
                        userController.userInfo = user;
                        // // userController.signupWithPhone(true, []);
                        userController.sendCode(context, true);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Obx(
                () => LoadingProgressbar(
                    loadingState: userController.isDataLoading),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userController.changeDataloading(false);
    super.dispose();
  }
}
