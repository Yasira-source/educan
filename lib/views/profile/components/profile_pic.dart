import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key? key,required this.profPic
  }) : super(key: key);
  String profPic;
  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ImagePicker _picker = ImagePicker();
  File? imagePicked;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  ? Image.network(widget.profPic,fit: BoxFit.fill,)
                  : Image.asset(
                      "assets/images/user.png",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
         
        ],
      ),
    );
  }

}
