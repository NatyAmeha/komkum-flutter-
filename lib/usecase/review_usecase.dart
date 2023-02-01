import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/review_viewmodel.dart';

class ReviewUsecase {
  IRepository reviewRepo;

  ReviewUsecase({required this.reviewRepo});

  Future<ReviewViewmodel?> getBusinessReview(String businessId,
      {String? key}) async {
    var result = await reviewRepo.get<ReviewViewmodel>("/business/reviews",
        queryParameters: {
          "id": businessId,
          "key": key,
          "page": 1,
          "size": 100
        });
    return result;
  }

  Future<ReviewViewmodel?> getServiceReview(String serviceId,
      {String? key}) async {
    var result = await reviewRepo.get<ReviewViewmodel>("/service/reviews",
        queryParameters: {"id": serviceId, "key": key, "page": 1, "size": 100});
    return result;
  }
}
