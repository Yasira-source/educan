
import 'package:educanapp/views/home/home_screen.dart';
import 'package:educanapp/views/subscription_page/subscription_page.dart';
import 'package:flutter/material.dart';

import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';

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
            subTitleText: "Your Current Subscription Plan can not enable you to access this file",
          ),
          DefaultButton(
            btnText: 'Subscribe Now',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SubscriptionDetails(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
