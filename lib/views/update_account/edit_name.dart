import 'package:educanapp/views/update_account/user/user_data.dart';
import 'package:educanapp/views/update_account/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  void updateUserValue(String name) {
    user.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 330,
                    child: Text(
                      "What's Your Name?",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              // Handles Form Validation for First Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                } else if (!isAlpha(value)) {
                                  return 'Only Letters Please';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'First Name'),
                              controller: firstNameController,
                            ))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              // Handles Form Validation for Last Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                } else if (!isAlpha(value)) {
                                  return 'Only Letters Please';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Last Name'),
                              controller: secondNameController,
                            )))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: const Color(0xFF1A8F00)
                            ),
                            onPressed: () async{
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  isAlpha(firstNameController.text +
                                      secondNameController.text)) {

                                SharedPreferences pref = await SharedPreferences.getInstance();
                                // pref.remove("username");
                                await pref.setString("username",'${firstNameController.text} ${secondNameController.text}');
                                await pref.setString("lname",secondNameController.text);
                                await pref.setString("fname",firstNameController.text);
                                updateUserValue(firstNameController.text +
                                    " " +
                                    secondNameController.text);


                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ],
            ),
          ),
        ));
  }
}
