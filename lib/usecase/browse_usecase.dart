import 'package:komkum/model/repo/repository.dart';
import 'package:komkum/viewmodel/browse_viewmodel.dart';
import 'package:komkum/viewmodel/search_viewmodel.dart';

class BrowseUsecase {
  IRepositroy<BrowseViewmodel> browseRepo;

  BrowseUsecase({required this.browseRepo});

  Future<BrowseViewmodel?> getHomepage() async {
    var result = await this.browseRepo.get<BrowseViewmodel>("/browse");
    return result;
  }

  Future<SearchViewmodel?> serach(String query,
      {int page = 1, int pageSize = 100}) async {
    var result = await this.browseRepo.get<SearchViewmodel>("/browse/search",
        queryParameters: {"query": query, "page": page, "limit": pageSize});
    return result;
  }
}
