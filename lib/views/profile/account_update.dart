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

class updateAccount2 extends StatefulWidget {
  updateAccount2(
      {Key? key,
      required this.email,
      required this.password,
      required this.names,
      required this.othernames,
      required this.fnames,
  
      required this.address,
      required this.mobile,
  
      required this.uid,
      required this.profPic,
      required this.passwordx})
      : super(key: key);

  String email;
  String password;
  String names;
  String othernames;
  String fnames;
 
  String address;
  String mobile;
 
  String uid;
  String profPic;
  String passwordx;
  @override
  State<updateAccount2> createState() => _updateAccount2State();
}

class _updateAccount2State extends State<updateAccount2> {
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
              "Update Account",
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
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: (widget.profPic != '')
                              ? Image.network(
                                  widget.profPic,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  "assets/images/user.png",
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white),
                              ),
                              primary: Colors.white,
                              backgroundColor: const Color(0xFFF5F6F9),
                            ),
                            onPressed: () async {
                              file = await getImage();
                              var requestn = http.MultipartRequest(
                                  'POST',
                                  Uri.parse(
                                      'https://eaoug.org/admin/app/api/member/update_photo.php'));
                              requestn.fields['uid'] = widget.uid;
                              requestn.files.add(http.MultipartFile.fromBytes(
                                  'id_photo', File(file.path).readAsBytesSync(),
                                  filename: file.path));
                              Get.dialog(
                                Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 8),
                                        Text('Uploading Photo.....'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              var res = await requestn.send();
                              if (Get.isDialogOpen!) Get.back();
                              // var gotn = json.decode(res);
                              // print(got);
if(res.statusCode==200){
   Get.off(() => UpdateSuccess(
                                  sub:
                                      'Your Photo has been Updated Successfully !'));
}
                           
                            },
                            child: SvgPicture.asset(
                              "assets/icons/Camera Icon.svg",
                              color: const Color(0xFF02182e),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                IntlPhoneField(
                  initialCountryCode: "UG",
                  initialValue: widget.mobile,
                  // controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (phone) {
                    setState(() {
                      widget.mobile = phone.number;
                    });
                  },
                  onCountryChanged: (country) {
                    // if (kDebugMode) {
                    //   print('Country changed to: ' + country.name);
                    // }
                  },
                ),
               
              
                const SizedBox(height: 10),
                buildSurNamesFormField(),
                const SizedBox(height: 10),
                buildFirstNamesFormField(),
                const SizedBox(height: 10),
                buildOtherNamesFormField(),
                const SizedBox(height: 10),
                buildAddressFormField(),
                const SizedBox(height: 10),
                buildEmailFormField(),
                const SizedBox(height: 10),
                buildPasswordFormField(),
                const SizedBox(height: 10),
                buildConformPassFormField(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  width: 140,
                  child: InkWell(
                    onTap: () async {
                      result = await controller.updateData(
                          widget.fnames,
                          widget.names,
                          widget.othernames,
                          widget.mobile,
                          widget.email,
                          widget.address,
                          widget.password,
                          widget.uid);
                      // print(result);
                      var got = json.decode(result);
                      // print(got);
                      if (got[0]['message'] == 'Yes') {
                        Get.off(() => UpdateSuccess(
                            sub:
                                'Your Account has been Updated Successfully !'));
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
        // obscureText: true,
        initialValue: widget.password,
        onSaved: (newValue) => widget.password = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.isNotEmpty && widget.passwordx == widget.password) {
            removeError(error: kMatchPassError);
          }
          widget.password = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if ((widget.password != value)) {
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Re-enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible! ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF02a54d),
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible!;
              });
            },
          ),
        ),
        obscureText: _passwordVisible!);
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        // obscureText: true,
        initialValue: widget.passwordx,
        onSaved: (newValue) => widget.passwordx = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 4) {
            removeError(error: kShortPassError);
          }
          widget.passwordx = value;
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
          labelText: "Password ( To be used to access the Mobile App)",
          hintText: "Enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible! ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF02a54d),
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible!;
              });
            },
          ),
        ),
        obscureText: _passwordVisible!);
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: widget.email,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => setState(() {
        widget.email = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
          setState(() {
            widget.email = value;
          });
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
          setState(() {
            widget.email = value;
          });
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
        labelText: "Active Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }


  TextFormField buildAddressFormField() {
    return TextFormField(
      initialValue: widget.address,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.address = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.address = value;
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
        labelText: "Shipping Address",
        hintText: "Enter your Desired Shipping Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildSurNamesFormField() {
    return TextFormField(
      initialValue: widget.names,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.names = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.names = value;
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
        labelText: "Surname",
        hintText: "Enter your surname",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNamesFormField() {
    return TextFormField(
      initialValue: widget.fnames,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.fnames = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.fnames = value;
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
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildOtherNamesFormField() {
    return TextFormField(
      initialValue: widget.othernames,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        widget.othernames = newValue!;
      }),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          setState(() {
            widget.othernames = value;
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
        labelText: "Other names",
        hintText: "Enter your other names",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future<File> getImage() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
    File file = File(image!.path);
//print(‘Image picked’);
    return file;
  }
}
