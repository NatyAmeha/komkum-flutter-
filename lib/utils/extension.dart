import 'package:komkum/model/business.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/notification.dart';
import 'package:komkum/model/order.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/model/user.dart';
import 'package:komkum/viewmodel/browse_viewmodel.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';
import 'package:komkum/viewmodel/review_viewmodel.dart';
import 'package:komkum/viewmodel/search_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

extension apiResponseconverter on dynamic {
  dynamic toObject(String className) {
    print("class name is ${className.toString()}");
    switch (className) {
      case "Business":
        return Business.fromJson(this);
      case "Service":
        return Service.fromJson(this);
      case "User":
        return User.fromJson(this);
      case "Notification":
        return Notification.fromJson(this);
      case "Review":
        return Review.fromJson(this);
      case "Coupon":
        return Coupon.fromJson(this);
      case "Order":
        return Order.fromJson(this);

      case "Product":
        return Product.fromJson(this);

      case "BrowseViewmodel":
        return BrowseViewmodel.fromJson(this);

      case "BusienssViewmodel":
        return BusienssViewmodel.fromJson(this);

      case "CouponViewmodel":
        return CouponViewmodel.fromJson(this);

      case "ProductViewmodel":
        return ProductViewmodel.fromJson(this);

      case "ReviewViewmodel":
        return ReviewViewmodel.fromJson(this);
      case "ServiceViewmodel":
        return ServiceViewmodel.fromJson(this);

      case "SearchViewmodel":
        return SearchViewmodel.fromJson(this);

      case "String":
      case "bool":
        return this;
      default:
        null;
    }
  }
}
