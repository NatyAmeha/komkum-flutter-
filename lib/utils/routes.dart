import 'package:go_router/go_router.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/page/error_page.dart';
import 'package:komkum/view/page/home_page.dart';
import 'package:komkum/view/screen/business_list_screen.dart';
import 'package:komkum/view/screen/business_screen.dart';
import 'package:komkum/view/screen/ccoupon_customization_screen.dart';
import 'package:komkum/view/screen/coupon_list_screen.dart';
import 'package:komkum/view/screen/coupons_screen.dart';
import 'package:komkum/view/screen/home_screen.dart';
import 'package:komkum/view/screen/login_screen.dart';
import 'package:komkum/view/screen/order_details_screen.dart';
import 'package:komkum/view/screen/order_list_screen.dart';
import 'package:komkum/view/screen/order_summary_screen.dart';
import 'package:komkum/view/screen/product_detail_screen.dart';
import 'package:komkum/view/screen/product_list_screen.dart';
import 'package:komkum/view/screen/register_screen.dart';
import 'package:komkum/view/screen/review_list_screen.dart';
import 'package:komkum/view/screen/service_detail_screen.dart';
import 'package:komkum/view/screen/verification_screen.dart';
import 'package:komkum/view/screen/write_review_screen.dart';
import 'package:komkum/view/widget/service_widget/product_list.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class AppRoute {
  static var routes = GoRouter(
    initialLocation: HomeScreen.routeName,
    routes: [
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
          path: ServiceDetailScreen.routeName,
          builder: (context, state) {
            var serviceId = state.params["id"];

            return serviceId != null
                ? ServiceDetailScreen(serviceId: serviceId)
                : ErrorPage();
          }),
      GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: RegistrationScreen.routeName,
        builder: (context, state) => RegistrationScreen(),
      ),
      GoRoute(
        path: OrderDetailsScreen.routeName,
        builder: (context, state) {
          var orderId = state.params["id"];
          return orderId != null
              ? OrderDetailsScreen(orderId: orderId)
              : ErrorPage();
        },
      ),
      GoRoute(
        path: OrderListScreen.routeName,
        builder: (context, state) => OrderListScreen(),
      ),
      GoRoute(
        // parentNavigatorKey: _rootNavigatorKey,
        path: VerificationScreen.routeName,
        name: VerificationScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;
          var verificactionId = args["verificationId"] as String;
          var isloggedinBefore = args["isLoggedinBefore"] as bool;
          print("route variables $verificactionId $isloggedinBefore");
          return VerificationScreen(
              verificationId: verificactionId,
              isLoggedinBefore: isloggedinBefore);
        },
      ),
      GoRoute(
        path: ProductDetailScreen.routeName,
        builder: (context, state) {
          var productId = state.params["id"];

          return productId != null
              ? ProductDetailScreen(productId: productId)
              : ErrorPage();
        },
      ),
      GoRoute(
        name: ProductListScreen.routeName,
        path: ProductListScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;
          var title = args["TITLE"] as String;

          var listDataType = args["DATA_TYPE"] as ProductListDataType?;
          var products = args["PRODUCTS"] as List<ProductViewmodel>?;

          return ProductListScreen(
            title: title,
            listDataType: listDataType,
            products: products,
          );
        },
      ),
      GoRoute(
        path: BusinessScreen.routeName,
        builder: (context, state) {
          var businessId = state.params["id"];

          return businessId != null
              ? BusinessScreen(businessId: businessId)
              : ErrorPage();
        },
      ),
      GoRoute(
        name: BusinessListScreen.routeName,
        path: BusinessListScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;
          var title = args["TITLE"] as String;

          var listDataType = args["DATA_TYPE"] as BusinessListDataType?;
          var products = args["BUSINESSES"] as List<BusienssViewmodel>?;

          return BusinessListScreen(
            title: title,
            dataType: listDataType,
            businesses: products,
          );
        },
      ),
      GoRoute(
        path: CouponScreen.routeName,
        builder: (context, state) {
          var couponId = state.params["id"];

          return couponId != null
              ? CouponScreen(couponId: couponId)
              : ErrorPage();
        },
      ),
      GoRoute(
        path: CouponListScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;
          var coupons = args["coupons"] as List<CouponViewmodel>?;
          return CouponListScreen(coupons: coupons);
        },
      ),
      GoRoute(
        name: ReviewListScreen.routeName,
        path: ReviewListScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;
          var reviewType = args["type"] as ReviewDataType? ??
              ReviewDataType.BUSINESSS_REVIEW;
          var name = args["name"] as String;
          var id = state.queryParams["id"];
          print("review id $id");
          return ReviewListScreen(
            name: name,
            reviewType: reviewType,
            id: id,
          );
        },
      ),
      GoRoute(
        // parentNavigatorKey: _rootNavigatorKey,
        path: WriteReviewScreen.routeName,
        name: WriteReviewScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>;
          var title = args["TITLE"] as String;
          var reviewInfo = args["REVIEW"] as Review;
          var keyPoints = args["KEYPOINTS"] as String?;
          print("route reivew $keyPoints");
          return WriteReviewScreen(
            title: title,
            review: reviewInfo,
            reviewKeys: keyPoints?.split(",") ?? [],
          );
        },
      ),
      GoRoute(
        // parentNavigatorKey: _rootNavigatorKey,
        path: OrderSummaryScreen.routeName,
        name: OrderSummaryScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>?;
          var callToAction = args?["CALLTOACTION"] as String?;
          var orderName = args?["ORDERNAME"] as String?;

          return OrderSummaryScreen(
            callToAction: callToAction,
            orderName: orderName,
          );
        },
      ),
      GoRoute(
        // parentNavigatorKey: _rootNavigatorKey,
        path: CouponCustomizationScreen.routeName,
        name: CouponCustomizationScreen.routeName,
        builder: (context, state) {
          var args = state.extra as Map<String, dynamic>?;
          var couponInfo = args?["COUPON"] as CouponViewmodel;
          var callToAction = args?["CALLTOACTION"] as String;
          var products = args?['PRODUCTS'] as List<Product>;

          return CouponCustomizationScreen(
            couponViewmodel: couponInfo,
            callToActionText: callToAction,
            serviceProducts: products,
          );
        },
      ),
    ],
  );
}
