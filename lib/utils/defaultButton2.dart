
import 'package:flutter/material.dart';

import 'constants_new.dart';

class DefaultButton2 extends StatelessWidget {
  final Widget? btnText;
  final VoidCallback onPressed;
  const DefaultButton2({
    Key? key, this.btnText, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: kLessPadding),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kShape)),
        color: kPrimaryColor,
        textColor: kWhiteColor,
        highlightColor: kTransparent,
        onPressed: onPressed,
        child: btnText!,
      ),
    );
  }
}