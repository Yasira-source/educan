
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/constants_new.dart';
import '../../utils/widgets/emptySection.dart';
import '../notification/components/defaultAppBar.dart';
import '../notification/components/defaultBackButton.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF1A8F00),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Ionicons.chevron_back,
        //     color: Colors.white,
        //   ),
        // ),
        title: const Text("Chat"),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: EmptySection(
              emptyImg: conversation,
              emptyMsg: "No message yet",
            ),
          ),
          Expanded(
            flex: 0,
            child: Material(
              elevation: kLess,
              color: kWhiteColor,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: kLess),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.attach_file,
                        color: kPrimaryColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: kLess),
                        padding: EdgeInsets.symmetric(horizontal: kLessPadding),
                        decoration: BoxDecoration(
                            border: Border.all(color: kAccentColor),
                            color: kWhiteColor),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your message",
                            hintStyle: TextStyle(color: kLightColor),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                    ),
                      IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
