
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';
import '../home/home_screen.dart';

class PayErrorMessage extends StatefulWidget {
  PayErrorMessage(this.message,{Key? key}) : super(key: key);
  String message;

  @override
  _PayErrorMessageState createState() => _PayErrorMessageState();
}

class _PayErrorMessageState extends State<PayErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptySection(
            emptyImg: callCenter,
            emptyMsg: 'Sorry !!',
          ),
          SubTitle(
            subTitleText: widget.message,
          ),
          DefaultButton(
            btnText: 'Try Again',
            onPressed: () => Get.to(()=>HomeScreen()),
          ),
        ],
      ),
    );
  }
}
