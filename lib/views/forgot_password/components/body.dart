// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:educanapp/controller/forgot_password_controller.dart';
import 'package:educanapp/views/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../utils/components/custom_surfix_icon.dart';
import '../../../utils/components/default_button.dart';
import '../../../utils/components/form_error.dart';
import '../../../utils/components/no_account_text.dart';
import '../../../utils/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou an email with a temporary password to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
   String? email;
  String? phoneNum;
  final controller = ForgotPasswordController();
  var result;

  
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          IntlPhoneField(
            initialCountryCode: "UG",
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            onChanged: (phone) {
              // print(phone.completeNumber);
              setState(() {
                phoneNum = phone.number;
              });
            },
            onCountryChanged: (country) {
              // print('Country changed to: ' + country.name);
            },
          ),
          SizedBox(
            height: 20,
          ),
          buildEmailFormField(),
          SizedBox(height: 30),
          FormError(errors: errors),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Do what you want to do

                print(email);
                print(phoneNum);

                result = await controller.postData(email!, phoneNum!);
                // print(result);
                // if(result)
                // var got = json.decode(result);
                // // print(got['message']);
                // if (got !=null) {
                  _showMyDialog1(email!);
                // } else {
                  // _showMyDialog();
                // }
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }


  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Process Failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Kindly try again '),
                Text('to reset your password'),
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

  Future<void> _showMyDialog1(String em) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Successful'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('Kindly check the entered email address '),
                Text(' $em for a temporary password to Continue'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Get.off(() => SignInScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
