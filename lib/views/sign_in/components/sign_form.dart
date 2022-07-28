// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:educanapp/models/login_model.dart';
import 'package:educanapp/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/sign_in_controller.dart';
import '../../../utils/components/custom_surfix_icon.dart';
import '../../../utils/components/default_button.dart';
import '../../../utils/components/form_error.dart';
import '../../../utils/components/no_account_text.dart';
import '../../../utils/constants.dart';
import '../../../utils/keyboard.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? phoneNum;
  bool? _passwordVisible;
  TextEditingController? phoneController;
  TextEditingController? passwordController;
  bool remember = false;
  final List<String> errors = [];
  final controller = SignInController();

  var result;

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
  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // buildEmailFormField(),
          IntlPhoneField(
            initialCountryCode: "UG",
            controller: phoneController,
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

          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Get.to(() => ForgotPasswordScreen()),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),

          FormError(errors: errors),
          SizedBox(height: 20),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                // print(phoneController!.text);
                // print(password);
                // print(phoneNum);

                result = await controller.getData(phoneNum!, password!);
                // print(result);
                var got = json.decode(result);
                // print(got['message']);
                if (got['success']) {
                  actionTaken(got);
                } else {
                  _showMyDialog();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  actionTaken(var got) async {
    // print(got['data']['display_name']);
// store data using shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("username", got['display_name']);
    await pref.setString("uid", got['id']);
    await pref.setString("fname", got['display_name']);
    await pref.setString("lname", got['display_name']);
    await pref.setString("phone", got['phone']);
    await pref.setString("email", got['email']);

    Get.off(() => HomeScreen(
          // username: got['display_name'],
          // fname: got['phone'],
          // uid: got['id'],
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Kindly enter correct Phone Number '),
                Text('and Password to Continue'),
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      // obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 4) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               _passwordVisible!
               ? Icons.visibility
               : Icons.visibility_off,
               color: Colors.black45,
               ),
            onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
               setState(() {
                   _passwordVisible = !_passwordVisible!;
               });
             },
            ),
      ),
       obscureText:_passwordVisible!,

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
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
