import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

import '../../controller/flutterwave_payments_controller.dart';
import '../../utils/keyboard.dart';
import '../success/success.dart';
class BankCardDetails extends StatefulWidget {
  BankCardDetails(this.amount,this.planId, {Key? key}) : super(key: key);
  String amount;
  String planId;
  @override
  BankCardDetailsState createState() => BankCardDetailsState();
}

class BankCardDetailsState extends State<BankCardDetails> {

  var f = NumberFormat("###,###", "en_US");
  String cardNumber = '';
  String expiryDate= '';
  String cardHolderName = '';
  String cvvCode= '';
  bool isCvvFocused = false;
  var result;
  var result1;
  var result2;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controller = FlutterWavePaymentsController();

  String email ='';
  String uid='';
  @override
  void initState() {
    super.initState();
    _loadCounterx();
  }

  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      email = (prefs.getString('email') ?? '');
      uid = (prefs.getString('uid') ?? '');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text("Card Details"),
      ),
      body: ListView(
        shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 10,),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Carefully Enter your Card Details: "),
            ),
          ),
          const SizedBox(height: 10,),
          Column(
            children: [
              CreditCardForm(cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: onCreditCardModelChange,
                themeColor: Colors.blue,
                formKey: formKey,
                cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Number',
                    hintText: 'xxxx xxxx xxxx xxxx'
                ),
                expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expiry Date',
                    hintText: 'xx/xx'
                ),
                cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'xxx'
                ),
                cardHolderDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Holder\' Names',
                ),
              ),

            ],
          ),

          const SizedBox(height: 10,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1A8F00))),
                onPressed: () async{
                  if(formKey.currentState!.validate()){

                    formKey.currentState!.save();
                    // if all are valid then go to success screen
                    KeyboardUtil.hideKeyboard(context);


                    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                    Random _rnd = Random();
                    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
                        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
                    var str = expiryDate;
                    if (str.length >= 3) {
                      str = str.substring(0, str.length - 3);
                    }
                    print(str);
                    var rcode =getRandomString(15);
                    result2 = await controller.encodeCardPayment(cardNumber,cvvCode,str,expiryDate.substring(3),widget.amount,email,cardHolderName,rcode);
// print(result2);
                    final url =json.decode(result2);
                    if( canLaunch(url) != null){
                      launch(url);
                      result1 = await controller.subscribePlan(uid, widget.amount, widget.planId, rcode, "Success");
                      Get.to(()=>Success(sub: "Your Payment has been made Successfully!",));
                    }
                    else {
                      throw 'Could not launch $url';
                    }
                    // result = await controller.initiateCardPayment(result2);

                    // print(result);
                    // var got = json.decode(result);
                    // print(got['message']);
                    // if (got['status']=="success") {
                      // complete the payment
                      //  redirect
                      // final url =got['meta']['authorization']['redirect'];
                      // if( canLaunch(url) != null){
                      //   launch(url);
                      //   result1 = await controller.subscribePlan(uid, widget.amount, widget.planId, rcode, "Success");
                      //   Get.to(Success(sub: "Your Payment has been made Successfully!",));
                        //  get feedback from the webhook and complete the process
                        //   Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //           builder: (context) => Success(sub: "Your Payment has been made Successfully!",)
                        //       ),
                      // }
                      // else {
                      //   throw 'Could not launch $url';
                      // }




                    //
                    // } else {
                    //   _showMyDialog();
                    // }
                  }

                },
                child:  Text('  PAY NOW: UGX ${f.format(double.parse(widget.amount))}  ',style: const TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel){
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Kindly try again '),
                Text('with the right details'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



