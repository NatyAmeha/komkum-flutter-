import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:get/get.dart';
import 'package:komkum/model/repo/api_repository.dart';
import 'package:komkum/model/user.dart';
import 'package:komkum/usecase/browse_usecase.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/viewmodel/browse_viewmodel.dart';

class AppController extends GetxController {
  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var loggedInUser = User().obs;
  User get loggedInUserResult => loggedInUser.value;

  BrowseViewmodel? browseResult;

  var myPageStack = FirstAndLastPageStack(initialPage: 0);

  @override
  void onInit() {
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
}
