
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/constants_new.dart';
import '../../utils/widgets/emptySection.dart';

class Message extends StatefulWidget {
  Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar:  AppBar(
        backgroundColor: Color(0xFF1A8F00),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Ionicons.chevron_back,
        //     color: Colors.white,
        //   ),
        // ),
        title: Text("Messages"),
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
      body: EmptySection(
        emptyImg: chatBubble,
        emptyMsg: 'No message yet',
      ),
    );
  }
}
