import 'dart:convert';

import 'package:educanapp/controller/base_controller.dart';
import 'package:educanapp/helper/dialog_helper.dart';
import 'package:educanapp/services/app_exceptions.dart';
import 'package:educanapp/services/base_client.dart';
import 'package:get/get.dart';

class FlutterWavePaymentsController extends GetxController with BaseController {

  initiateMMPayment(
      String phone,String net,String amount, String email,String ref) async {
    var request = {
      'phone_number': phone,
      'network': net,
      'amount': double.parse(amount),
      'currency': 'UGX',
      'email': email,
      'tx_ref': ref,
    };
    showLoading('Initiating Payment...');
    var response = await BaseClient()
        .postH('https://api.flutterwave.com',
        '/v3/charges?type=mobile_money_uganda', request)
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

  initiateCardPayment(String cno) async {




    var request = {
      "client": cno,
      // "enckey":'1ac1d3c428bf2361b6e4fd3c'
    };
    showLoading('Submitting Payment...');
    var response = await BaseClient()
        .postH('https://api.flutterwave.com',
        '/v3/charges?type=card', request)
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


  subscribePlan(
      String user_id,String amount,String plan, String sref,String status) async {
    var request = {
      'user_id': user_id,
      'amount': amount,
      'plan': plan,
      'sref': sref,
      'status': status,
    };
    // showLoading('Initiating Payment...');
    var response = await BaseClient()
        .post('https://educanug.com/educan_new/educan/api',
        '/plan/subscribe_to_plan.php', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);

      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    // hideLoading();
    // print(response);
    return response;
  }
  encodeCardPayment(
      String cno,String cvv,String emonth, String eyear,String amount,String email,String names,String ref) async {
    var request = {
      "card_number": cno,
      "cvv": cvv,
      "expiry_month": emonth,
      "expiry_year": eyear,
      "currency": "UGX",
      "amount": double.parse(amount),
      "email": email,
      "fullname": names,
      "tx_ref": ref,
      "enckey": "1ac1d3c428bf2361b6e4fd3c"
    };
    showLoading('Initiating Payment...');
    var response = await BaseClient()
        .postH('https://educanug.com/educan_new/educan/api',
        '/user/encrypt_card_details.php', request)
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

  CardPayment(
      String amount,String email,String names) async {
    var request = {

      "amount": double.parse(amount),
      "email": email,
      "fullname": names,
    };
    showLoading('Initiating Payment...');
    var response = await BaseClient()
        .postH('https://educanug.com/educan_new/educan/api',
        '/user/encrypt_card_details.php', request)
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

  uploadCartItem(String uid,String pid,String qty,int shop) async {
    var request = {
      "user_id": uid,
      "product_id": pid,
      "quantity": qty,
      "shop_type": shop,
    };
    // https://educanug.com/educan_new/educan/api/cart/add_single_cart_item_bookshop.php?user_id=10&product_id=519&quantity=1
    // showLoading('Fetching Cart...');
    var response = await BaseClient()
        .post('https://educanug.com/educan_new/educan/api',
        '/cart/add_single_cart_item_bookshop.php', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);

      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    // hideLoading();
    // print(response);
    return response;
  }
  uploadCartItem2(String uid,String pid,String qty,int shop) async {
    var request = {
      "user_id": uid,
      "product_id": pid,
      "quantity": qty,
      "shop_type": shop,
    };
    // https://educanug.com/educan_new/educan/api/cart/add_single_cart_item_bookshop.php?user_id=10&product_id=519&quantity=1
    // showLoading('Fetching Cart...');
    var response = await BaseClient()
        .post('https://educanug.com/educan_new/educan/api',
        '/cart/add_single_cart_item_ecom.php', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);

      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    // hideLoading();
    // print(response);
    return response;
  }

  createOrder(String uid,String pm,String pmt,int ps,String tid,String amount) async {
    var request = {
      "customer_id": uid,
      "payment_method": pm,
      "payment_method_title": pmt,
      "set_paid": ps,
      "transaction_id": tid,
      "amount": amount,
    };
    // https://educanug.com/educan_new/educan/api/cart/add_single_cart_item_bookshop.php?user_id=10&product_id=519&quantity=1
    showLoading('Submitting Order...');
    var response = await BaseClient()
        .post('https://educanug.com/educan_new/educan/api',
        '/user/create_order.php', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);

      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    // hideLoading();
    // print(response);
    return response;
  }


  checkWavePayment() async {
    // showLoading('Initiating Payment...');
    var response = await BaseClient()
        .get('https://educanug.com/educan_new/educan/api',
        '/user/wave_verify_2.php')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);

      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    // hideLoading();
    // print(response);
    return response;
  }
}
