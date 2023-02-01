import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';

class BusinessUsecase {
  IRepository businessRepo;

  BusinessUsecase({required this.businessRepo});

  Future<BusienssViewmodel?> getBusinessDetails(String businessId) async {
    var result =
        await businessRepo.get<BusienssViewmodel>("/business/$businessId");
    return result;
  }

  Future<bool> addBusinessToFavorite(String businessId) async {
    var result = await businessRepo.update<bool, dynamic>("/business/like",
        queryParameters: {"id": businessId});

    return result;
  }

  Future<bool> removeBusinessFromFavorite(String businessId) async {
    var result = await businessRepo.update<bool, dynamic>("/business/unlike",
        queryParameters: {"id": businessId});
    return result;
  }
}
