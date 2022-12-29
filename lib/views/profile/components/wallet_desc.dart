import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/transactions_model.dart';
import '../../../theme.dart';

import 'package:http/http.dart' as http;

import '../../subscription_page/enter_topup_amount.dart';

class WalletDescPage extends StatefulWidget {
  @override
  _WalletDescPageState createState() => _WalletDescPageState();
}

class _WalletDescPageState extends State<WalletDescPage> {
  int activeDay = 3;
  String uid = '';
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeff5f3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text(
          "Educan Wallet",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SvgPicture.asset(
                    'assets/icons/1017280091582962144.svg',
                    color: const Color(0xFF1A8F00),
                    width: 22,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "The Educan Wallet enables you to send money for FREE, withdraw money for less, earn 10% interest onyour balance, and affordably pay for utility bills such as Yaka!, NWSC, & TV!",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Here's how to add money to your wallet",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF02182e)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: InkWell(
                      onTap: () {
                        // cartController.addProduct(data);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //               builder: (context) => EnterDonationAmount(
                        //                 id: "1",
                        //               )));
                         Get.to(EnterDonationAmount2(id: '1',));
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A8F00),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'Add Money to Wallet',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
