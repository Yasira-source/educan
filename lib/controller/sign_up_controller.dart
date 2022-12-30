import 'dart:convert';

import 'package:educanapp/controller/base_controller.dart';
import 'package:educanapp/helper/dialog_helper.dart';
import 'package:educanapp/services/app_exceptions.dart';
import 'package:educanapp/services/base_client.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController with BaseController {
 

  

  postData(String fullnames, String email, String phone,
      String passchange, String referedBy, String password) async {
    var request = {
      'fullnames': fullnames,
      'email': email,
      'phone': phone,
      'roles': 2,
      'passchange': passchange,
      'refered_by': referedBy,
      'password': password
    };
    showLoading('Registering an account...');
    var response = await BaseClient()
        .post('https://educanug.com/educan_new/educan/api',
            '/user/register.php', request)
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

 updateData(String fname, String mname,String lname, String mobile,String email,String address,String password,String uid) async {
    var request = {
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'mobile': mobile,
      'email': email,
      'address': address,
       'id': uid,
         'password': password,
    };
    showLoading('Updating your account...');
    var response = await BaseClient()
        .post('https://eaoug.org/admin/app/api/member',
            '/update_member.php', request)
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

  postLessonOrder(String user_id, String mode, String details,
      String lclass, String subject, String concept,String attendants,String hours,String location) async {
    var request = {
      'user_id': user_id,
      'mode': mode,
      'details': details,
      'lclass': lclass,
      'subject': subject,
      'concept': concept,
      'attendants': attendants,
      'hours': hours,
      'location': location,
    };
    showLoading('Submitting Lesson Order...');
    var response = await BaseClient()
        .post('https://educanug.com/educan_new/educan/api',
        '/user/order_lesson.php', request)
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
