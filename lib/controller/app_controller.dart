import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:get/get.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/model/repo/shared_pref_repo.dart';
import 'package:komkum/model/user.dart';
import 'package:komkum/service/account_service.dart';
import 'package:komkum/usecase/browse_usecase.dart';
import 'package:komkum/usecase/user_usecase.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/browse_viewmodel.dart';
import 'package:komkum/viewmodel/search_viewmodel.dart';

class AppController extends GetxController {
  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var loggedInUser = User().obs;
  User get loggedInUserResult => loggedInUser.value;

  BrowseViewmodel? browseResult;
  SearchViewmodel? searchResult;

  var myPageStack = FirstAndLastPageStack(initialPage: 0);

  @override
  void onInit() async {
    await checkUserLoginStatus();
    getHomepage();
    super.onInit();
  }

  getHomepage() async {
    try {
      //remove any exception
      _exception(AppException());
      _isDataLoading(true);

      var browseRepo = BrowseUsecase(browseRepo: ApiRepository());
      var result = await browseRepo.getHomepage();
      browseResult = result;
    } catch (ex) {
      print(" exception ${ex.toString()}");
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getHomepage();
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  Future<SearchViewmodel?> search(String query,
      {int page = 1, int pageSize = 100}) async {
    try {
      //remove any exception
      print("search data");

      var browseRepo = BrowseUsecase(browseRepo: ApiRepository());
      var result =
          await browseRepo.serach(query, page: page, pageSize: pageSize);
      print("search data $result");
      searchResult = result;
      return searchResult;
    } catch (ex) {
      print("search exception ${ex.toString()}");
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        search(query, page: page, pageSize: pageSize);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  checkUserLoginStatus() async {
    var userUsecase = UserUsecase(
      accountService: FirebaseAuthService(),
      sharedPrefRepo: const SharedPreferenceRepository(),
    );
    var result = await userUsecase.getUserInfoFromPref();

    if (result != null) loggedInUser(result);
  }

  logout() async {
    var sharedPrefRepo = const SharedPreferenceRepository();
    sharedPrefRepo.delete(Constants.TOKEN);
    await sharedPrefRepo.delete(Constants.USERNAME);
    await sharedPrefRepo.delete(Constants.USER_ID);
    // await sharedPrefRepo.delete(Constants.TOKEN);

    loggedInUser(User());
  }
}
