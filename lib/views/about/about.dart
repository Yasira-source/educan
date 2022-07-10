
import 'package:educanapp/utils/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/constants_new.dart';
import '../notification/components/defaultAppBar.dart';
import '../notification/components/defaultBackButton.dart';
import '../notification/components/notificationTiles.dart';
import 'components/descSection.dart';

class About extends StatefulWidget {
  About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
        title: Text("About Application"),
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
        children: [
          NotificationTiles(
            title: 'Educan App',
            subtitle: 'Values Beyond School',
            enable: false,
          ),
          Divider(),
          DescSection(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
          ),
          DescSection(
            text:
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",
          ),
          SizedBox(height: 15,),
          Divider(),
          
          Text("Give Us a review or a 5-star rating on Play Store or App Store"),
          SizedBox(height: 15,),
          SizedBox(width:200,
         child: DefaultButton(text: "Rate Us ✦ ✦ ☆ ☆ ☆",press: (){},),
          
          ),
        ],
      ),
    );
  }
}
