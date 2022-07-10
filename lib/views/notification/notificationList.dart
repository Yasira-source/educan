
import 'package:ionicons/ionicons.dart';

import '../../utils/constants_new.dart';
import 'components/defaultBackButton.dart';
import 'package:flutter/material.dart';
import 'components/defaultAppBar.dart';
import 'components/notificationTiles.dart';
import 'notificationPage.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
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
      body: ListView.separated(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 1,
          itemBuilder: (context, index) {
            return NotificationTiles(
              title: 'Educan App',
              subtitle: 'Thanks for downloading the Educan app.',
              enable: true,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage())),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }
}
