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

enum ServiceListType { HORIZONTAL, GRID, VERTICAL }

enum ProductListType { GRID, HORIZONTAL }

enum BusinessListType { HORIZONTAL, VERTICAL }

var serviceINfo = Service(
    name: "Room Service",
    tags: ["tag1 ", "tag2 "],
    description:
        "hotel service enabling guests to choose items of food and drink for delivery to their hotel room for consumption.",
    coupons: ["coupon 1", "coupon 2"],
    images: [
      "https://hmhub.in/wp-content/uploads/2019/08/top-room-service.jpg",
      "https://media.cntraveler.com/photos/53d9d8606dec627b149db98b/master/pass/hotel-room-service-breakfast-tray.jpg",
      "https://www.alyeskaresort.com/wp-content/uploads/2020/07/roomservice-1a.jpg",
      "https://media.istockphoto.com/id/627892060/photo/hotel-room-suite-with-view.jpg?s=612x612&w=0&k=20&c=YBwxnGH3MkOLLpBKCvWAD8F__T-ypznRUJ_N13Zb1cU="
    ],
    serviceItems: ["", ""]);

Product product = Product(
    name: "Family room",
    description:
        "hotel service enabling guests to choose items of food and drink for delivery to their hotel room for consumption.",
    businesName: "Haile Resort",
    callToAction: "Book ",
    images: [
      "https://hmhub.in/wp-content/uploads/2019/08/top-room-service.jpg",
      "https://media.cntraveler.com/photos/53d9d8606dec627b149db98b/master/pass/hotel-room-service-breakfast-tray.jpg",
      "https://www.alyeskaresort.com/wp-content/uploads/2020/07/roomservice-1a.jpg",
    ],
    category: "Room",
    fixedPrice: 200,
    moreInfo: {"more info": "2", "more info 2": "2"},
    variants: [
      ProductVariant(
          images: [
            "https://www.alyeskaresort.com/wp-content/uploads/2020/07/roomservice-1a.jpg",
            "https://hmhub.in/wp-content/uploads/2019/08/top-room-service.jpg",
          ],
          fixedPrice: 200,
          moreInfo: {"More info": "More info 1", "info 2": "More info 2"}),
      ProductVariant(
          images: [
            "https://www.alyeskaresort.com/wp-content/uploads/2020/07/roomservice-1a.jpg",
            "https://hmhub.in/wp-content/uploads/2019/08/top-room-service.jpg",
          ],
          minPrice: 100,
          maxPrice: 500,
          moreInfo: {"More info": "More info 1", "info 2": "More info 2"}),
      ProductVariant(
          images: [
            "https://www.alyeskaresort.com/wp-content/uploads/2020/07/roomservice-1a.jpg",
            "https://hmhub.in/wp-content/uploads/2019/08/top-room-service.jpg",
          ],
          fixedPrice: 200,
          moreInfo: {"More info": "More info 1", "info 2": "More info 2"}),
      ProductVariant(
          images: [
            "https://www.alyeskaresort.com/wp-content/uploads/2020/07/roomservice-1a.jpg",
            "https://hmhub.in/wp-content/uploads/2019/08/top-room-service.jpg",
          ],
          minPrice: 100,
          maxPrice: 500,
          moreInfo: {"More info": "More info 1", "info 2": "More info 2"}),
    ]);

Coupon coupon = Coupon(
    name: "Coupon name 1",
    description:
        "Coupon name  a;ljdfaksd flaskd 1 description. Coupon name 1 description. Coupon name 1 description",
    images: [
      "https://hmhub.in/wp-content/uploads/2019/08/top-room-service.jpg",
      "https://media.cntraveler.com/photos/53d9d8606dec627b149db98b/master/pass/hotel-room-service-breakfast-tray.jpg",
      "https://www.alyeskaresort.com/wp-content/uploads/2020/07/roomservice-1a.jpg",
    ]);

CouponViewmodel couponViewmode = CouponViewmodel(couponInfo: coupon);

List<ServiceViewmodel> serviceList = [
  ServiceViewmodel(service: serviceINfo, serviceItems: [product, product]),
  ServiceViewmodel(service: serviceINfo)
];
