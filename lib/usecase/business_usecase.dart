import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';

class BusinessUsecase {
  IRepositroy businessRepo;

  BusinessUsecase({required this.businessRepo});

  Future<BusienssViewmodel?> getBusinessDetails(String businessId) async {
    var result =
        await businessRepo.get<BusienssViewmodel>("/business/$businessId");
    return result;
  }
}
