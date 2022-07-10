import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/sign_up/sign_up_screen.dart';
import '../constants.dart';


class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Get.to(()=>SignUpScreen()),
          child: const Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
