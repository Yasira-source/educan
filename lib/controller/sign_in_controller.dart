
import 'package:educanapp/controller/base_controller.dart';
import 'package:educanapp/services/base_client.dart';
import 'package:get/get.dart';

class SignInController extends GetxController with BaseController {
  // var loginData = <Data>[].obs;
  

  getData(String username, String password) async {
    showLoading('Authenticating data...');
    var response = await BaseClient()
        .get('https://educanug.com/educan_new/educan/api',
            '/user/login_new.php?username=$username&password=$password')
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    // print(response);
  
    return response;
  }
}
