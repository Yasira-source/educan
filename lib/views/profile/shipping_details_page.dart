import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../controller/cart_controller.dart';
import '../../controller/sign_up_controller.dart';
import '../../utils/components/custom_surfix_icon.dart';
import '../cart/cart_screen.dart';
import '../success/reg_error_page.dart';
import '../success_pages/update_success_page.dart';

class updateAccount3 extends StatefulWidget {
  updateAccount3(
      {Key? key,
      required this.district,
      required this.country,
      required this.city,
      required this.other,
      required this.uid,})
      : super(key: key);

  String district;
  String country;

  String city;
 
  String other;
 
  String uid;
  @override
  State<updateAccount3> createState() => _updateAccount3State();
}

class _updateAccount3State extends State<updateAccount3> {
  final cartController = Get.put(CartController());
  final _formKey = GlobalKey<FormState>();
  late File file;
  final List<String> errors = [];
  var result;
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  bool? _passwordVisible;

  int _currentTimeValue = 1;
  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  final controller = SignUpController();

  @override
  void initState() {
    _passwordVisible = false;
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
              "Update Shipping Info",
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
              
               
                buildCountryFormField(),
                const SizedBox(height: 10),
               buildDistrictFormField(),
                const SizedBox(height: 10),
               buildCityFormField(),
                const SizedBox(height: 10),
               buildOtherFormField(),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 60,
                  width: 140,
                  child: InkWell(
                    onTap: () async {
                      result = await controller.updateShippingData(
                          widget.country,
                          
                          widget.district,
                          widget.city,
                          widget.other,
                          widget.uid);
                      // print(result);
                      var got = json.decode(result);
                      // print(got);
                      if (got[0]['message'] == 'Yes') {
                        Get.off(() => UpdateSuccess(
                            sub:
                                'Your Shipping Details have been Updated Successfully !'));
                      } else {
                        // _showMyDialog(got['message']);
                        Get.to(() => RegErrorMessage(got[0]['message']));
                      }
                      // if all are valid then go to success screen

                      // }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A8F00),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Update',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
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
        ),
      ),
    );
  }


  TextFormField buildCountryFormField() {
    return TextFormField(
      initialValue: widget.country,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.country = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.country = value;
          });
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Country",
        hintText: "Enter your Shipping Country",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }


  TextFormField buildDistrictFormField() {
    return TextFormField(
      initialValue: widget.district,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.district = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.district = value;
          });
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "District",
        hintText: "Enter your Shipping District",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  
  TextFormField buildCityFormField() {
    return TextFormField(
      initialValue: widget.city,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.city = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.city = value;
          });
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "City / Town",
        hintText: "Enter your Shipping town",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  
  TextFormField buildOtherFormField() {
    return TextFormField(
      initialValue: widget.other,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.other = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.other = value;
          });
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Any Other Useful Details for successful Shipping",
        hintText: "Enter any other useful info",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
 
}
