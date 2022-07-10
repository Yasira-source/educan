
import 'package:flutter/material.dart';

import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/defaultTextField.dart';
import '../../utils/widgets/headerLabel.dart';
import '../notification/components/defaultAppBar.dart';
import '../notification/components/defaultBackButton.dart';
import '../payment/payment.dart';

class DeliveryAddress extends StatefulWidget {
  DeliveryAddress({Key? key}) : super(key: key);

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Delivery Address",
        child: DefaultBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderLabel(
              headerText: "Where are your ordered items shipped?",
            ),
            DefaultTextField(
              hintText: "State",
              icon: Icons.map,
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: kFixPadding,
            ),
            DefaultTextField(
              hintText: "City",
              icon: Icons.location_city,
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: kFixPadding,
            ),
            DefaultTextField(
              hintText: "Locality",
              icon: Icons.landscape,
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: kFixPadding,
            ),
            DefaultTextField(
              hintText: "Pincode",
              icon: Icons.location_city,
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            DefaultButton(
              btnText: "Go to payment",
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Payment(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
