import 'package:go_router/go_router.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/page/error_page.dart';
import 'package:komkum/view/page/home_page.dart';
import 'package:komkum/view/screen/business_screen.dart';
import 'package:komkum/view/screen/coupon_list_screen.dart';
import 'package:komkum/view/screen/coupons_screen.dart';
import 'package:komkum/view/screen/home_screen.dart';
import 'package:komkum/view/screen/login_screen.dart';
import 'package:komkum/view/screen/product_detail_screen.dart';
import 'package:komkum/view/screen/register_screen.dart';
import 'package:komkum/view/screen/service_detail_screen.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

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
        path: ProductDetailScreen.routeName,
        builder: (context, state) {
          var productId = state.params["id"];

          return productId != null
              ? ProductDetailScreen(productId: productId)
              : ErrorPage();
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
          }),
    ],
  );
}
