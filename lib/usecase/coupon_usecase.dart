import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

class CouponUsecase {
  IRepository couponRepo;

  CouponUsecase({required this.couponRepo});

  Future<CouponViewmodel?> getCouponDetails(String couponId) async {
    var couponResult =
        await couponRepo.get<CouponViewmodel>("/coupon/$couponId");
    return couponResult;
  }
}
