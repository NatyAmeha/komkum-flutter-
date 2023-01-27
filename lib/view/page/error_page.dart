import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_text.dart';

class ErrorPage extends StatelessWidget {
  var appController = Get.find<AppController>();

  AppException? exception;
  IconData icon;
  bool showIcon;

  ErrorPage({
    this.exception,
    this.icon = Icons.error_outline_outlined,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    String btnText;
    String errorMessage;
    Function onClick;
    switch (exception?.type) {
      case AppException.UNAUTORIZED_EXCEPTION:
        btnText = "Sign in";
        errorMessage = "You need to sign in to continue.";
        onClick = () {
          // Get.toNamed(AccountOnboardingScreen.routName);
        };
        break;
      case AppException.NOT_FOUND_EXCEPTION:
        btnText = "Go back";
        errorMessage = "Unable to find what you are looking";
        onClick = () {
          context.pop();
        };
        break;
      case AppException.SERVER_EXCEPTION:
        btnText = "  Try again  ";
        errorMessage = "Server error ${exception?.message}";
        onClick = () {
          exception?.action?.call();
        };
        break;
      default:
        btnText = exception?.actionText ?? "  Try again  ";
        errorMessage = exception?.message ?? "";
        onClick = () {
          exception?.action?.call();
        };
        break;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon) Icon(icon, size: 100),
          const SizedBox(height: 24),
          CustomText(
            exception?.title ?? "",
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: CustomText(
              errorMessage,
              alignment: TextAlign.center,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          // if (message != null || exception?.message != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: CustomButton(
              btnText,
              wrapContent: true,
              onPressed: () {
                onClick();
              },
            ),
          ),
        ],
      ),
    );
  }
}
