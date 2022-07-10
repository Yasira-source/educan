

import 'package:educanapp/utils/widgets/headerLabel.dart';
import 'package:educanapp/views/notification/components/defaultAppBar.dart';
import 'package:educanapp/views/notification/components/defaultBackButton.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../success/success.dart';

class Payment extends StatefulWidget {
  Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar:  AppBar(
        backgroundColor: Color(0xFF1A8F00),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Ionicons.chevron_back,
        //     color: Colors.white,
        //   ),
        // ),
        title: Text("Payment Methods"),
        actions: [
         
             IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.search_outline,
              color: Colors.white,
            ),
          ),
           IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.cart_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          HeaderLabel(
            headerText: 'Choose your payment method',
          ),
          Expanded(
            child: ListView.separated(
              itemCount: paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: kPrimaryColor,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = i as int),
                  ),
                  title: Text(
                    paymentLabels[index],
                    style: TextStyle(color: kDarkColor),
                  ),
                  trailing: Icon(paymentIcons[index], color: kPrimaryColor),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          DefaultButton(
            btnText: 'Pay',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Success(sub: "Your Payment was done Successfully!",),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
