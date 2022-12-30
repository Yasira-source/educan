
import 'package:educanapp/views/subscription_page/enter_topup_amount.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';
import '../home/home_screen.dart';

class SubscribeMessage extends StatefulWidget {
  const SubscribeMessage({Key? key}) : super(key: key);


  @override
  _SubscribeMessageState createState() => _SubscribeMessageState();
}

class _SubscribeMessageState extends State<SubscribeMessage> {
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
          const SubTitle(
            subTitleText: "Your Current Wallet Balance is not enough to access this file",
          ),
          DefaultButton(
            btnText: 'Deposit Money Now',
            onPressed: () => Get.off(()=>EnterDonationAmount2(id: '1')),
          ),
        ],
      ),
    );
  }
}
