import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/controller/user_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/business_list_screen.dart';
import 'package:komkum/view/screen/login_screen.dart';
import 'package:komkum/view/screen/product_list_screen.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';

class AccountPage extends StatefulWidget {
  static const routeName = "/account";

  AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var userController = Get.put(UserController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      userController.getUserInfo(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("${userController.appController.loggedInUserResult.username}"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: userController.userGeneralINfo != null,
          exception: userController.exception,
          isDataLoading: userController.isDataLoading,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Column(
                    children: [
                      Obx(
                        () => ListTile(
                          leading: const Icon(Icons.account_circle, size: 50),
                          title: userController.appController.loggedInUserResult
                                      .username ==
                                  null
                              ? TextButton(
                                  child: CustomText("Register or Sign in"),
                                  onPressed: () {
                                    UIHelper.moveToLoginOrRegister(context);
                                  },
                                )
                              : CustomText(
                                  userController.appController
                                      .loggedInUserResult.username!,
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomContainer(
                        color: Colors.green[200],
                        padding: 8,
                        margin: 16,
                        child: ListTile(
                          title: CustomText(
                            "Your balance",
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: CustomText(
                            "16 Birr",
                            textStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          isThreeLine: false,
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: CustomText(
                          "My orders",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on_outlined),
                        title: CustomText(
                          "My Shipping addresses",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.reviews_outlined),
                        title: CustomText(
                          "My reviews",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          UIHelper.goToScreen(
                            context,
                            BusinessListScreen.routeName,
                            extra: {
                              "TITLE": "Favorite Businesses",
                              "DATA_TYPE":
                                  BusinessListDataType.USER_FAVORITE_BUSINESS
                            },
                          );
                        },
                        leading: const Icon(Icons.business_outlined),
                        title: CustomText(
                          "My Favorite businesses",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          UIHelper.goToScreen(
                            context,
                            ProductListScreen.routeName,
                            extra: {
                              "TITLE": "Favorite Products",
                              "DATA_TYPE":
                                  ProductListDataType.USER_FAVORITE_PRDUCTS
                            },
                          );
                        },
                        leading: const Icon(Icons.favorite_outline),
                        title: CustomText(
                          "My favorite products",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.badge),
                        title: CustomText(
                          "Feedback",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings_outlined),
                        title: CustomText(
                          "Settings",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        title: CustomText(
                          "About",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
