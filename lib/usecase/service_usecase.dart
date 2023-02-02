import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class ServiceUsecase {
  IRepository serviceRepo;

  ServiceUsecase({required this.serviceRepo});

  Future<ServiceViewmodel?> getServiceDetail(String serviceId) async {
    var serviceResult =
        await serviceRepo.get<ServiceViewmodel>("/service/$serviceId");
    return serviceResult;
  }

  Future<ProductViewmodel?> getProductInfo(String productId) async {
    var productResult =
        await serviceRepo.get<ProductViewmodel>("/service/product/$productId");
    return productResult;
  }

  Future<bool> addProductToFavorite(List<String> productIds) async {
    var result = await serviceRepo.update<bool, dynamic>("/user/products/add",
        queryParameters: {"ids": productIds.join(",")});
    print("product update result $result");
    return result;
  }

  Future<bool> removeProductFromFavorite(List<String> productIds) async {
    var result = await serviceRepo.update<bool, dynamic>(
        "/user/products/remove",
        queryParameters: {"ids": productIds.join(",")});
    return result;
  }

  Future<bool> addReviewToService(Review reviewInfo) async {
    var productResult = await serviceRepo.create<bool, Review>(
        "/service/review/add", reviewInfo);
    return productResult;
  }
}
