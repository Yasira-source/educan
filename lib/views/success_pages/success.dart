

import 'package:flutter/material.dart';

import '../../utils/constants_new.dart';
import '../../utils/defaultButton.dart';
import '../../utils/widgets/emptySection.dart';
import '../../utils/widgets/subTitle.dart';
import '../home/home_screen.dart';

class Success extends StatefulWidget {
   Success({Key? key,required this.sub}) : super(key: key);
String sub;
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            emptyImg: success,
            emptyMsg: 'Successful !!',
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
