
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/cart_controller.dart';
import '../../utils/components/custom_surfix_icon.dart';
import '../cart/cart_screen.dart';
import 'package:get/get.dart';

import '../payment_options/payment_options_2.dart';

class EnterDonationAmount2 extends StatefulWidget {
  EnterDonationAmount2({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  State<EnterDonationAmount2> createState() => _EnterDonationAmount2State();
}

class _EnterDonationAmount2State extends State<EnterDonationAmount2> {
  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String? amount;
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  int _currentTimeValue = 1;
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
      backgroundColor: const Color(0xFFeff5f3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Deposit Money",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)),
              Obx(
                () => Positioned(
                    top: 0,
                    right: 6,
                    child: cartController.products.length <= 0
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Text(
                              '${cartController.products.length}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          )),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => setState(() {
                    amount = newValue;
                  }),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        amount = value;
                      });
                      removeError(error: "Amount must be greater than 0");
                    }
                    return;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: "Amount must be greater than 0");
                      return "";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    hintText: "Enter amount",

                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: '+256757438443',
                );
                launchUrl(launchUri);
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A8F00),
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.white),
                ),
                child: const Icon(
                  Ionicons.call,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  // cartController.addProduct(data);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentOptions2(
                            amount: amount!,
                            planId: widget.id.toString(),
                          )));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A8F00),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    ' + Deposit Now',
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
    );
  }
}
