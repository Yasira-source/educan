import 'package:educanapp/views/payment_options/bank_card_details.dart';
import 'package:educanapp/views/payment_options/mobile_operator.dart';
import 'package:educanapp/views/payment_options/mobile_operator_2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';
import '../../controller/flutterwave_payments_controller.dart';
import 'bank_card_details_2.dart';
import 'cash_on_delivery.dart';

class TimePreferencesWidget extends StatefulWidget {
  TimePreferencesWidget(this.amount, {Key? key}) : super(key: key);
  String amount;

  @override
  TimePreferencesWidgetState createState() => TimePreferencesWidgetState();
}

class TimePreferencesWidgetState extends State<TimePreferencesWidget> {
  int _currentTimeValue = 1;
  var result;
  var result1;
  var result2;
  final controller = FlutterWavePaymentsController();

  String email ='';
  String uid='';
  String _pname='';
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
      _pname = (prefs.getString('name') ?? '');

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text("Payment Options"),
      ),
      body: ListView(
        shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 10,),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Select a payment option of your choice: "),
            ),
          ),
           RadioListTile<int>(
              groupValue: _currentTimeValue,
              title: const Text("Pay Easily with Mobile Money"),
              // subtitle: const Text("How to Pay:\n1. Confirm your Order\n2. You'll be redirected to the payment page\n3. Select your operator (Service Provider)\n4. Enter your Mobile Money number\n5. Click on Pay Now\n6. Check your phone for payment request\n7. Enter your MoMo PIN\n8. Approve payment to Jumia\n9. You will receive SMS/Email confirmation message for a successful payment.\n\nYour Payment is safe. If anything goes wrong we've got your back! "),
              value: 1,
              onChanged: (val) {
                setState(() {
                  debugPrint('VAL = $val');
                  _currentTimeValue = val!;
                });
              },
           ),
          RadioListTile<int>(
            groupValue: _currentTimeValue,
            title: const Text("Bank Cards"),
            // subtitle: const Text("Please make sure you have enough funds before proceeding to the next step.\n\nHow to Pay:\nOnce payment method is selected, you'll be redirected to the payment page\n1. Enter or select your cards' details\nProceed and enter the OTP (One-Time-Passcode) received from your bank.\n3. You will receive an SMS/Email confirmation message if the payment is/ not successful\n\nYour Payment is safe. If anything goes wrong, contact Us."),
            value: 2,
            onChanged: (val) {
              setState(() {
                debugPrint('VAL = $val');
                _currentTimeValue = val!;
              });
            },
          ),
          RadioListTile<int>(
            groupValue: _currentTimeValue,
            title: const Text("Cash On Delivery"),
            // subtitle: const Text("Pay Cash On Delivery!\n- Complete your order and pay cash when you receive your order.\n- Please make sure to have the exact amount with you, since the delivery agent might not have change"),
            value: 3,
            onChanged: (val) {
              setState(() {
                debugPrint('VAL = $val');
                _currentTimeValue = val!;
              });
            },
          ),
          const SizedBox(height: 10,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1A8F00))),
                onPressed: () {
                  if(_currentTimeValue==1){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MobileOperator2(
widget.amount,'MobileMoney','Mobile Money'
                        )));
                  }else if(_currentTimeValue==2){

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BankCardDetails2(
widget.amount,'CardPayments','Card Payment'
                        )));
                  }else if(_currentTimeValue==3){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CashOnDelivery(
widget.amount,'CashOnDelivery','Cash On Delivery'
                        )));
                  }

                },
                child: const Text('  PROCEED  ',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}