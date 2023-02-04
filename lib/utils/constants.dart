import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/view/widget/service_widget/service_list.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class Constants {
  static const REGISTERED = "REGISTEREND";
  static const LOGGED_IN = "LOGGED_IN";
  static const USER_ID = "USER_ID";
  static const TOKEN = "TOKEN";
  static const USERNAME = "USER_NAME";
  static const PHONE_NUMBER = "PHONE_NUMBER";
  static const PROFILE_IMAGE = "PROFILE_IMAGE";

  static const DEFAULT_NOTIFICATION_CHANNEL_ID =
      "DEFAULT_NOTIFICATION_CHANNEL_ID";
  static const DEFAULT_NOTIFICATION_CHANNEL_NAME =
      "DEFAULT_NOTIFICATION_CHANNEL_NAME";

  static const QUIZ_REWARD_NOTIFICATION = "QUIZ_REWARD";
}

enum AccountType { USER }

enum OrderType { BOOKING, PURCHASE }

enum ServiceListType { HORIZONTAL, GRID, VERTICAL, BUSINESS_SERVICES_LIST }

enum ProductListType { GRID, HORIZONTAL }

enum BusinessListType { HORIZONTAL, VERTICAL }

enum ReviewDataType { BUSINESSS_REVIEW, SERVCIE_REVIEW }

enum ProductListDataType { USER_FAVORITE_PRDUCTS }

enum BusinessListDataType { USER_FAVORITE_BUSINESS }
