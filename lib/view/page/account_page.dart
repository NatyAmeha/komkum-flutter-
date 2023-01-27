import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/login_screen.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_text.dart';

class AccountPage extends StatelessWidget {
  var appController = Get.find<AppController>();
  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: CustomButton(
        "Account page",
        onPressed: () {
          UIHelper.goToScreen(context, LoginScreen.routeName);
        },
      )),
    );
  }
}
