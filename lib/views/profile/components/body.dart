import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../orders/orders_page.dart';
import '../../sign_in/sign_in_screen.dart';
import '../../subscription_page/subscription_page.dart';
import '../account_update.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.uid, required this.pic,required this.upname,required this.email}) : super(key: key);
  String uid;
  String pic;
  String upname;
  String email;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List members = [];
  String refs = '';
  bool _switchValue = true;
  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.uid = (prefs.getString('uid') ?? '');
      refs = (prefs.getString('refs') ?? '');
    });
    getMembers(widget.uid);
  }

  Future<String> getMembers(String mid) async {
    var res = await http.get(Uri.parse(
        'https://eaoug.org/admin/app/api/member/get_members_info.php?id=$mid'));
    var resBody = json.decode(res.body);

    setState(() {
      members = resBody;
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
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(" Welcome ${widget.upname}!",
                      style: const TextStyle(color: Colors.yellow, fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(widget.email,
                      style: const TextStyle(color: Colors.white, fontSize: 12)),
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
                   SvgPicture.asset(
                  'assets/icons/wallet-svgrepo-com.svg',
                  color:  Colors.blue,
                  width: 22,
                ),
                const SizedBox(width: 20),
                const Expanded(child: Text('Your Wallet Balance: UGX 0',style: TextStyle(color: Colors.blue),)),
                ],
          ),
             ),
           ),
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('MY EDUCAN ACCOUNT',style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'Roboto',fontWeight: FontWeight.bold),),
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Buying()));
              },
            ),
            ProfileMenu(
              text: "My Educan Wallet",
              icon: "assets/icons/wallet-svgrepo-com.svg",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SubscriptionDetails()));
              },
            ),
            ProfileMenu(
              text: "Vouchers",
              icon: "assets/icons/Gift Icon.svg",
              press: ()  {
               
              },
            ),
             ProfileMenu(
              text: "Inbox",
              icon: "assets/icons/Log out.svg",
              press: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Get.off(() => const SignInScreen());
              },
            ),
              ],
            ),
          ),


            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('MY SETTINGS',style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'Roboto',fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          // const SizedBox(height: 10),

          Container(
            color: Colors.white,
            child: Column(
              children: [
  ProfileMenu(
              text: "Address Book",
              icon: "assets/icons/receipt.svg",
              press: () {
               
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => updateAccount(uid: uid,)))
              },
            ),
            ProfileMenu(
              text: "Account Management",
              icon: "assets/icons/User.svg",
              press: () {
                Get.to(() => updateAccount2(
                      email: members[0]['email'],
                      password: members[0]['pass'],
                      address: members[0]['address'],
                      fnames: members[0]['fname'],
                      names: members[0]['lname'],
                      mobile: members[0]['mobile'],
                      prof: members[0]['prof'],
                      dob: members[0]['dob'],
                      whatsapp: members[0]['phone'],
                      reason: members[0]['reason'],
                      nation: members[0]['nation'],
                      othernames: members[0]['mname'],
                      phoneNum: members[0]['other_phone'],
                      uid: widget.uid,
                      profPic: members[0]['prof_pic'],
                      passwordx: members[0]['pass'],
                    ));
              },
            ),
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 2),
              child: Row(
 children:  [
  SvgPicture.asset(
              'assets/icons/Bell.svg',
              color: const Color(0xFF02182e),
              width: 22,
            ),
            SizedBox(width: 20),
              Expanded(child: Text('Push Notifications')),
              
           
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
              press: () {
            
              },
            ),
           
              ],
            ),
          ),
const SizedBox(height: 13,),
          GestureDetector(
            onTap: () async{
               SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Get.off(() => const SignInScreen());
            },
            child: const Center(child: Text('LOGOUT',style: TextStyle(color: Color.fromARGB(255, 255, 22, 5),fontFamily: 'Roboto',fontWeight: FontWeight.bold),))
          ),
const SizedBox(height: 25,),

        
        
        ],
      ),
    );
  }
}
