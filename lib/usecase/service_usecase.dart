import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class ServiceUsecase {
  IRepositroy serviceRepo;

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
}
