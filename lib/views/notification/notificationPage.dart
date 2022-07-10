
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/constants_new.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
        title: Text("Notifications"),
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
      body: FittedBox(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(kFixPadding),
          padding: EdgeInsets.all(kFixPadding),
          decoration: BoxDecoration(
              color: kWhiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [BoxShadow(color: kLightColor, blurRadius: 2.0)]),
          child: Column(
            children: [
              Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: kDarkTextStyle),
              SizedBox(height: 16.0),
              Image(image: AssetImage(manShoes)),
              SizedBox(height: 16.0),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  style: TextStyle(color: kLightColor)),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: Text('11/Feb/2021 04:42 PM',
                    style: TextStyle(color: kLightColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
