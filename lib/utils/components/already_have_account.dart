import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/sign_in/sign_in_screen.dart';
import '../../views/sign_up/sign_up_screen.dart';
import '../constants.dart';


class AlreadyAccountText extends StatelessWidget {
  const AlreadyAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Get.to(()=>SignInScreen()),
          child: const Text(
            "Sign In",
            style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
