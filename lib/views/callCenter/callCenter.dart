
import 'package:educanapp/views/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';
import '../notification/components/defaultAppBar.dart';
import '../notification/components/defaultBackButton.dart';

class CallCenter extends StatefulWidget {
  CallCenter({Key? key}) : super(key: key);

  @override
  _CallCenterState createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF1A8F00),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Ionicons.chevron_back,
        //     color: Colors.white,
        //   ),
        // ),
        title: Text("Call Center"),
        actions: [
         
             IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.search_outline,
              color: Colors.white,
            ),
          ),
           IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.cart_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            emptyImg: callCenter,
            emptyMsg: "We're happy to help you!",
          ),
          SubTitle(
            subTitleText: "If you have any complaints about the product chat with Us",
          ),
          DefaultButton(
            btnText: "Chat With Us",
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Chat(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
