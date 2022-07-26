import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/flutterwave_payments_controller.dart';
import '../../utils/keyboard.dart';
import '../success/success.dart';
class MobileOperator extends StatefulWidget {
  MobileOperator(this.amount, this.planid,{Key? key}) : super(key: key);
  String amount;
  String planid;
  @override
  MobileOperatorState createState() => MobileOperatorState();
}

class MobileOperatorState extends State<MobileOperator> {
String email ='';
String uid ='';
final _formKey = GlobalKey<FormState>();
final controller = FlutterWavePaymentsController();

var result;
var result1;
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


  int _currentTimeValue = 1;
  var f = NumberFormat("###,###", "en_US");
  TextEditingController? phoneController;
  String? phoneNum;
  String? ccode;
final List<String> errors = [];
var isLoaded = false;

void addError({String? error}) {
  if (!errors.contains(error)) {
    setState(() {
      errors.add(error!);
    });
  }
}

void removeError({String? error}) {
  if (errors.contains(error)) {
    setState(() {
      errors.remove(error);
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text("Mobile Operator"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Select your mobile operator: "),
              ),
            ),
            RadioListTile<int>(
              groupValue: _currentTimeValue,
              title: const Text("MTN"),
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
              title: const Text("Airtel"),
              // subtitle: const Text("Please make sure you have enough funds before proceeding to the next step.\n\nHow to Pay:\nOnce payment method is selected, you'll be redirected to the payment page\n1. Enter or select your cards' details\nProceed and enter the OTP (One-Time-Passcode) received from your bank.\n3. You will receive an SMS/Email confirmation message if the payment is/ not successful\n\nYour Payment is safe. If anything goes wrong, contact Us."),
              value: 2,
              onChanged: (val) {
                setState(() {
                  debugPrint('VAL = $val');
                  _currentTimeValue = val!;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Insert your mobile number without 0: "),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: IntlPhoneField(
                initialCountryCode: "UG",
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (phone) {
                  // print(phone.completeNumber);
                  setState(() {
                    phoneNum = phone.completeNumber;
                    ccode = phone.countryCode;
                  });
                },
                onCountryChanged: (country) {
                  // print('Country changed to: ' + country.name);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF1A8F00))),
                  onPressed: () async{

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);

                      var net = '';
                      if(_currentTimeValue==1){
                        net = 'MTN';
                      }else if(_currentTimeValue==2){
                        net = 'AIRTEL';
                      }
                      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                      Random _rnd = Random();

                      String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
                          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

                        var rcode =getRandomString(15);
                      result = await controller.initiateMMPayment(phoneNum!.substring(1),net,widget.amount,email,rcode);
                      result1 = await controller.subscribePlan(uid, widget.amount, widget.planid, rcode, "Success");
                      // print(result1);
                      var got = json.decode(result);
                      // print(got['message']);
                      if (got['status']=="success") {
                        // complete the payment
                      //  redirect
                        final url =got['meta']['authorization']['redirect'];
                        if( canLaunch(url) != null){
                          launch(url);
                          Get.to(Success(sub: "Your Payment has been made Successfully!",));
                        //  get feedback from the webhook and complete the process
                        //   Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //           builder: (context) => Success(sub: "Your Payment has been made Successfully!",)
                        //       ),
                        }
                        else {
                          throw 'Could not launch $url';
                        }





                      } else {
                        _showMyDialog();
                      }
                    }
                  },
                  child: Text(
                    '  PAY NOW: UGX ${f.format(double.parse(widget.amount))}  ',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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


//
