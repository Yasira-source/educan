import 'dart:convert';

import 'package:educanapp/views/home/components/wallet_auth_page.dart';
import 'package:educanapp/views/products_list_page/product_card.dart';
import 'package:educanapp/views/profile/shipping_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../orders/orders_page.dart';
import '../../sign_in/sign_in_screen.dart';
import '../account_update.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  Body(
      {Key? key,
      required this.uid,
      required this.pic,
      required this.upname,
      required this.email,
      required this.pass})
      : super(key: key);
  String uid;
  String pic;
  String upname;
  String email;
  String pass;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List members = [];
  List membersx = [];
  String refs = '';
  bool _switchValue = true;
  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.uid = (prefs.getString('uid') ?? '');
      widget.pic = (prefs.getString('pic') ?? '');
      refs = (prefs.getString('refs') ?? '');
    });
    print(widget.uid);
    getMembers((prefs.getString('uid') ?? ''));
  }

  Future<String> getMembers(String mid) async {
    var res = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/user/get_members_info.php?id=$mid'));
    var resBody = json.decode(res.body);

    var resn = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/user/get_members_shipping.php?id=$mid'));
    var resnBody = json.decode(resn.body);

    setState(() {
      members = resBody;
      membersx = resnBody;
    });

    // print(resBody);

    return "";
  }

  @override
  void initState() {
    _loadCounterx();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF1A8F00),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(" Welcome ${widget.upname}!",
                      style:
                          const TextStyle(color: Colors.yellow, fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.email,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // ProfilePic(profPic: widget.pic),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/wallet-filled-money-tool.png',
                    color: Colors.blue,
                    width: 22,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Get.to(() => WalletAuth());
                          },
                          child: Row(
                            children: const [
                              Text(
                                'Your Wallet Balance: ....',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.remove_red_eye_rounded,
                                color: Colors.blue,
                              )
                            ],
                          ))),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text(
                  'MY EDUCAN ACCOUNT',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),

          Container(
            color: Colors.white,
            child: Column(
              children: [
                ProfileMenu(
                  text: "My Educan Shop Orders",
                  icon: "assets/icons/Bell.svg",
                  press: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Buying()));
                  },
                ),
                ProfileMenu(
                  text: "My Educan Wallet",
                  icon: "assets/icons/1017280091582962144.svg",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WalletAuth()));
                  },
                ),
                ProfileMenu(
                  text: "Vouchers",
                  icon: "assets/icons/Gift Icon.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Inbox",
                  icon: "assets/icons/Log out.svg",
                  press: () async {},
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text(
                  'MY SETTINGS',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),

          Container(
            color: Colors.white,
            child: Column(
              children: [
                ProfileMenu(
                  text: "Your Shipping Address Details",
                  icon: "assets/icons/receipt.svg",
                  press: () {
                   
                    Get.to(() => updateAccount3(
                          country: membersx[0]['country'] ?? '',
                          district: membersx[0]['district'] ?? '',
                          city: membersx[0]['city'] ?? '',
                          other: membersx[0]['other'] ?? '',
                          uid: widget.uid,
                        ));
                  },
                ),
                ProfileMenu(
                  text: "Account Management",
                  icon: "assets/icons/User.svg",
                  press: () {
                    Get.to(() => updateAccount2(
                          email: members[0]['email'],
                          password: widget.pass,
                          fnames: members[0]['fname'],
                          mobile: members[0]['mobile'],
                          uid: widget.uid,
                          profPic: members[0]['prof_pic'],
                          passwordx: widget.pass,
                        ));
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 2),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Bell.svg',
                        color: const Color(0xFF02182e),
                        width: 22,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(child: Text('Push Notifications')),
                      CupertinoSwitch(
                        value: _switchValue,
                        onChanged: (value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ProfileMenu(
                  text: "Close Account",
                  icon: "assets/icons/Question mark.svg",
                  press: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          GestureDetector(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Get.off(() => const SignInScreen());
              },
              child: const Center(
                  child: Text(
                'LOGOUT',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 22, 5),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ))),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
