
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';

class RegErrorMessage extends StatefulWidget {
   RegErrorMessage(this.message,{Key? key}) : super(key: key);
String message;

  @override
  _RegErrorMessageState createState() => _RegErrorMessageState();
}

class _RegErrorMessageState extends State<RegErrorMessage> {
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
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
