import 'package:educanapp/views/login_in_screen.dart';
import 'package:educanapp/views/sign_in/sign_in_screen.dart';
import 'package:educanapp/views/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 236, 250, 1),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          Container(
            height: size.height / 3,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/learn.png"),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          Center(
            child: Text(
              "Welcome Back!",
              style: TextStyle(
                  fontSize: size.width / 14, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          Center(
            child: Text("Educan App a new way to Connect ",
                style: TextStyle(
                    fontSize: size.width / 20, fontWeight: FontWeight.w500)),
          ),
          Center(
            child: Text(
              "with people.",
              style: TextStyle(
                  fontSize: size.width / 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: size.height / 10,
          ),
          customButton(size, const Color.fromRGBO(129, 110, 217, 1), "Create Account",
              () {
            Get.to(()=>const SignUpScreen());
          }),
          customButton(size, const Color.fromRGBO(244, 136, 36, 1), "Log In", () {
            Get.to(()=>const SignInScreen());
          }),
        ],
      ),
    );
  }

  Widget customButton(Size size, Color color, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          color: color,
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: size.height / 12,
            width: size.width / 1.7,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width / 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
