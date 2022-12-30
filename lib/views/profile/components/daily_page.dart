
import 'dart:convert';

import 'package:educanapp/views/subscription_page/enter_topup_amount.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/transactions_model.dart';
import '../../../theme.dart';

import 'package:http/http.dart' as http;

class DailyPage extends StatefulWidget {


  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
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
  Future<List<TransactionsData>> fetchRelated2(String tag) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/user/get_app_six_months_trans.php?id=$tag'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => TransactionsData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeff5f3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title:  const Text(
          "Wallet Transactions",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
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
            decoration: BoxDecoration( boxShadow: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "All your Previous Transactions",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF02182e)),
                      ),
                      // Icon(AntDesign.search1)
                    ],
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                children:[
                  SizedBox(
                    height: 502,
                    child: FutureBuilder<List<TransactionsData>>(
                        future: fetchRelated2(uid),
                        builder: (context, snapshot) {
                          // print(snapshot.error);
                          if (snapshot.hasData) {
                            List<TransactionsData>? data = snapshot.data;
                            if(data!.length==1){
                          return Column(
                            children:  [
                              const SizedBox(height: 10,),
                              const Text("You've not made any transactions yet!", style: TextStyle(fontSize: 15,color: Color(0xFF1A8F00)),),
const SizedBox(height: 20,),
                                SizedBox(
                                  height: 50,
                                  width: 180,
              child: InkWell(
                onTap: () {
            
                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EnterDonationAmount2(
                                  id: "1",
                                )));

                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF1A8F00),
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
                          );

                        }
                            else{
                            return SizedBox(
                              height: 500,
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, position) {
                                  return transactionItem(data: data[position]);
                                },
                              ),
                            );
                          }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
    ]
                )),

          const SizedBox(
            height: 15,
          ),
         
        ],
      ),
    );
  }
}

Widget transactionItem({TransactionsData? data}) {
  var f = NumberFormat("###,###", "en_US");
  String title;
  String amount;
  String icon;
  String ddate;
  String status;
  bool ch = true;
  ddate = data!.dateCreated!;
if (data.type == "W" || data.type == "L" || data.type == "LE") {
        icon = 'assets/18.gif';
        amount = '-${f.format(int.parse(data.amount!))}';
        ch = false;
        status = data.status == '1' ? 'Successful' : 'Pending';
        if (data.type == "W") {
        
        title = '${data.reason} ($status)';
        } else {
         
        title = '${data.reason} ($status)';
        }
      } else if (data.type == "A" || data.type == "D" ) {
        icon = 'assets/17.gif';
        amount = '+${f.format(int.parse(data.amount!))}';
        status = data.status == '1' ? 'Successful' : 'Pending';
        if (data.type == "D") {
          
        title = '${data.reason} ($status)';
        } else {
          
        title = '${data.reason} ($status)';
        }

        // title = '${data.reason} ($status)';
      } else {
        icon = 'assets/17.gif';
        amount = '+${f.format(int.parse(data.amount!))}';
        status = data.status == '1' ? 'Successful' : 'Pending';
       
      
        title = '${data.reason} ($status)';
        
      }

  return Container(
    padding: const EdgeInsets.all(1),
    margin: const EdgeInsets.only(
      bottom: 8,
    ),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(18),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(icon),
      title: Text(
        title,
        style: blackTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
      subtitle: Text(
        ddate,
        style: greyTextStyle.copyWith(
          fontSize: 12,
        ),
      ),
      trailing: Text(
        amount,
        style: ch
            ? blackTextStyle.copyWith(
          fontSize: 16,
        )
            : redTextStyle.copyWith(
          fontSize: 16,
        ),
      ),
    ),
  );
}