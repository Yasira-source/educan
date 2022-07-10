import 'package:flutter/material.dart';

import '../constants_new.dart';

class HeaderLabel extends StatelessWidget {
  final String headerText;
  const HeaderLabel({
    Key? key, required this.headerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Text(
        headerText,
        style: TextStyle(color: kLightColor, fontSize: 28.0),
      ),
    );
  }
}