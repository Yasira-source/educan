import 'package:educanapp/views/referrals/referrals_page.dart';
import 'package:educanapp/views/updates_page/updates_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../orders/orders_page.dart';
import '../../sign_in/sign_in_screen.dart';
import '../../update_account/profile_page.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:get/get.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Update Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(

            )))
            },
          ),
          ProfileMenu(
            text: "Orders",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Buying(

                  )));
            },
          ),
          // ProfileMenu(
          //   text: "App Referrals",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => ReferralsPage(
          //
          //         )));
          //   },
          // ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Question mark.svg",
          //   press: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => UpdatesPage(
          //
          //         )));
          //   },
          // ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async{
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.clear();
              Get.to(()=>const SignInScreen());
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const SignInScreen(
              //     )));
            },
          ),
        ],
      ),
    );
  }
}
