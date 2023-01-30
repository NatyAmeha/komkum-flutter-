import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:komkum/controller/user_controller.dart';
import 'package:komkum/model/user.dart' as AppUser;
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/custom_text_field.dart';
import 'package:komkum/view/widget/loading_progressbar.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "/register";
  String? redirectRoute;

  RegistrationScreen({this.redirectRoute});

  var phoneNumberController = TextEditingController();
  var userNameController = TextEditingController();

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var userController = Get.put(UserController());
  String completePhoneNumber = "";
  @override
  Widget build(BuildContext context) {
    userController.redirectUrl = widget.redirectRoute;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            UIHelper.goBack(context);
          },
        ),
        title: CustomText("Register"),
      ),
      body: Stack(
        children: [
          // CustomImage(
          //   "assets/images/offline.jpg",
          //   height: double.infinity,
          //   width: double.infinity,
          //   srcLocation: "assets",
          // ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  // CustomImage(
                  //   "assets/images/app_icon.png",
                  //   srcLocation: "asset",
                  //   width: 70,
                  //   height: 70,
                  // ),
                  const SizedBox(height: 24),
                  CustomImage(
                    "assets/images/app_icon_foreground.png",
                    srcLocation: "assets",
                    width: 150,
                    height: 150,
                  ),

                  const SizedBox(height: 32),
                  IntlPhoneField(
                    autofocus: false,
                    disableLengthCheck: true,
                    controller: widget.phoneNumberController,
                    decoration: const InputDecoration(
                      fillColor: Colors.grey,
                      labelText: "Phone number",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    initialCountryCode: 'ET',
                    onChanged: (phone) {
                      setState(() {
                        completePhoneNumber = phone.completeNumber;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: "Name",
                    autoFocus: false,
                    controller: widget.userNameController,
                    onchanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Obx(
                      () => CustomButton(
                        enabled: !userController.isDataLoading &&
                            widget.userNameController.text.isNotEmpty &&
                            completePhoneNumber.length >= 10,
                        "Register",
                        onPressed: () async {
                          var user = AppUser.User(
                            username: widget.userNameController.text,
                            phoneNumber: completePhoneNumber,
                            fcmToken: [],
                            accountType: AccountType.USER.name,
                            userBusinesses: [],
                            favoriteProducts: [],
                            favoriteBusinesses: [],
                          );
                          userController.userInfo = user;
                          userController.sendCode(context, false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
    Future.delayed(Duration.zero, () {
      userController.changeDataloading(false);
    });
    super.dispose();
  }
}
