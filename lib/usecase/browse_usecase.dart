import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/browse_viewmodel.dart';

class BrowseUsecase {
  IRepositroy<BrowseViewmodel> browseRepo;

  BrowseUsecase({required this.browseRepo});

  Future<BrowseViewmodel?> getHomepage() async {
    var result = await this.browseRepo.get<BrowseViewmodel>("/browse");
    return result;
  }
}
