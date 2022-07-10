import 'dart:convert';

import 'package:educanapp/controller/base_controller.dart';
import 'package:educanapp/helper/dialog_helper.dart';
import 'package:educanapp/services/app_exceptions.dart';
import 'package:educanapp/services/base_client.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController with BaseController {
 

  

  postData( String email, String phone) async {
    var request = {
     
      'email': email,
      'phone': phone,
     
    };
    showLoading('Submitting reset request...');
    var response = await BaseClient()
        .post('https://educanug.com/educan_new/educan/api',
            '/user/update_password.php', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    hideLoading();
    // print(response);
    return response;
  }
}
