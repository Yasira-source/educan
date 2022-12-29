

import 'package:flutter/material.dart';

import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';
import '../home/home_screen.dart';

class UpdateSuccess extends StatefulWidget {
   UpdateSuccess({Key? key,required this.sub}) : super(key: key);
String sub;
  @override
  _UpdateSuccessState createState() => _UpdateSuccessState();
}

class _UpdateSuccessState extends State<UpdateSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptySection(
            emptyImg: success,
            emptyMsg: 'Successful !',
          ),
          SubTitle(
            subTitleText: widget.sub,
          ),
          DefaultButton(
            btnText: 'Ok',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
