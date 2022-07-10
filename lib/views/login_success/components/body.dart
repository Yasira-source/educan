import 'package:educanapp/views/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/components/default_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: MediaQuery.of(context).size.height * 0.4, //40%
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        const Text(
          "Thanks for Joining\n Educan Services!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.4,
          child: DefaultButton(
            text: "Continue ",
            press: () {
              // Navigator.pushNamed(context, HomeScreen.routeName);
              Get.off(() => SignInScreen());
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
