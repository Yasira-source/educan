import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../controller/sign_up_controller.dart';
import '../../../utils/components/custom_surfix_icon.dart';
import '../../../utils/components/default_button.dart';
import '../../../utils/components/form_error.dart';
import '../../../utils/constants.dart';
import '../../complete_profile/complete_profile_screen.dart';
import '../../login_success/login_success_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? names;
  bool? _passwordVisible;
  // ignore: non_constant_identifier_names
  String? conform_password;
  bool remember = false;
  String? phoneNum;
  final List<String> errors = [];

  var result;
  final controller = SignUpController();

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
          IntlPhoneField(
            initialCountryCode: "UG",
            // controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            onChanged: (phone) {
              phoneNum = phone.number;
            },
            onCountryChanged: (country) {
              // if (kDebugMode) {
              //   print('Country changed to: ' + country.name);
              // }
            },
          ),
          buildNamesFormField(),
          SizedBox(height: 30),
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: 40),
          DefaultButton(
            text: "Join Us",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // print(phoneController!.text);
                // print(password);
                // print(phoneNum);

                result = await controller.postData(
                    names!, email!, phoneNum!, "F", "", password!);
                // print(result);
                var got = json.decode(result);
                // print(got['message']);
                if (got['success']) {
                  Get.off(() => LoginSuccessScreen());
                } else {
                  _showMyDialog2();
                }
                // if all are valid then go to success screen

              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(String em) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(em),
                // Text("Choose another one"),
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
  Future<void> _showMyDialog2() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Process Failed!'),
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
  TextFormField buildConformPassFormField() {
    return TextFormField(
      // obscureText: true,
      onSaved: (newValue) => conform_password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
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
               color: Color(0x661A8F00),
         ),
          onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
               setState(() {
                   _passwordVisible = !_passwordVisible!;
               });
             },
       ),
      
      ),
      obscureText:_passwordVisible!
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
        password = value;
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
               color: Color(0x661A8F00),
         ),
          onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
               setState(() {
                   _passwordVisible = !_passwordVisible!;
               });
             },
       ),
      ),
      obscureText:_passwordVisible!
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

  TextFormField buildNamesFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => names = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
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
        labelText: "Fullnames",
        hintText: "Enter your fullnames",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
