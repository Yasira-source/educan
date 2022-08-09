import 'dart:async';

import 'package:educanapp/views/update_account/user/user_data.dart';
import 'package:educanapp/views/update_account/widgets/display_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart_controller.dart';
import '../cart/cart_screen.dart';
import 'edit_description.dart';
import 'edit_email.dart';
import 'edit_image.dart';
import 'edit_name.dart';
import 'edit_phone.dart';
import 'user/user.dart';

import 'package:get/get.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
  String _pname = '';
  String upname = '';
  String phone ='';
  String uid = '';
  String email = '';
  @override
  void initState() {
    super.initState();
    _loadCounterx();
  }

  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');
      phone = (prefs.getString('phone') ?? '');
      _pname = (prefs.getString('username') ?? '');
      email = (prefs.getString('email') ?? '');
      final x = _pname.split(" ");
      upname = x[0];
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text(
          "Update Account",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
                    child: cartController.products.length +
                        cartController.productsx.length ==
                        0
                        ? Container()
                        : Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '${cartController.products.length + cartController.productsx.length}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [

          const SizedBox(height: 5,),
          InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              )),
          buildUserInfoDisplay(_pname, 'Name', const EditNameFormPage()),
          buildUserInfoDisplay(phone, 'Phone', const EditPhoneFormPage()),
          buildUserInfoDisplay(email, 'Email', const EditEmailFormPage()),

          // buildUserInfoDisplay(user.name, 'Name', const EditNameFormPage()),
          // buildUserInfoDisplay(user.phone, 'Phone', const EditPhoneFormPage()),
          // buildUserInfoDisplay(user.email, 'Email', const EditEmailFormPage()),
          Expanded(
            flex: 4,
            child: buildAbout(user),
          )
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 90,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.aboutMeDescription,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
