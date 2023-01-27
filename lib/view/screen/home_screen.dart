import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/view/page/account_page.dart';
import 'package:komkum/view/page/home_page.dart';
import 'package:komkum/view/page/order_page.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  HomeScreen({super.key});

  var appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      lazyLoadPages: true,
      extendBody: true,
      savePageState: true,
      pages: [
        (_) => HomePage(),
        (_) => OrderPage(),
        (_) => AccountPage(),
      ],
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Account")
        ],
        onTap: onTap,
        currentIndex: currentIndex,
      ),
    );
  }
}
