import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/home_screen.dart';
import 'package:komkum/view/screen/login_screen.dart';
import 'package:komkum/view/widget/custom_button.dart';

class AccountPage extends StatelessWidget {
  static const routeName = "/account";
  var appController = Get.find<AppController>();
  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: CustomButton(
        "${appController.loggedInUserResult.username}",
        onPressed: () {
          UIHelper.moveToLoginOrRegister(context,
              redirectTo: HomeScreen.routeName);
        },
      )),
    );
  }
}
