
import 'dart:convert';

import 'package:educanapp/utils/defaultButton2.dart';
import 'package:educanapp/views/home/home_screen.dart';
import 'package:educanapp/views/success/payment_failed_screen.dart';
import 'package:educanapp/views/success/success.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../controller/flutterwave_payments_controller.dart';
import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';

class PaymentWait extends StatefulWidget {
  PaymentWait({Key? key,required this.uid,required this.amount,required this.planId,required this.rcode}) : super(key: key);
  String rcode;
  String amount;
  String planId;
  String uid;
  @override
  _PaymentWaitState createState() => _PaymentWaitState();
}

class _PaymentWaitState extends State<PaymentWait> {
  bool isLoading = false;
var result1;
  final controller = FlutterWavePaymentsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptySection(
            emptyImg: 'assets/images/giphy-1.gif',
            emptyMsg: '',
          ),
          const SubTitle(
            subTitleText: 'Press the button below once you\'re done with the Payment',
          ),


          DefaultButton2(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              result1 = await controller.checkWavePayment();
              // await Future.delayed(const Duration(seconds: 5));
              var got = json.decode(result1);
              setState(() {
                isLoading = false;
              });

              // print(got['message']);
              if (got['message']!='') {
                 result1 = await controller.subscribePlan(widget.uid, widget.amount, widget.planId, widget.rcode, "Success");
                 Get.to(()=>Success(sub: "Your Payment has been made Successfully!",));
              } else {
                // _showMyDialog(got['message']);
                Get.to(()=>PayErrorMessage('Transaction not Completed !'));
              }
            },
            btnText: (isLoading)
                ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,
                ))
                : const Text('Done'),

            ),

        ],
      ),
    );
  }
}
