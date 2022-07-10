import 'package:flutter/material.dart';
import '../../../utils/constants_new.dart';

class DescSection extends StatelessWidget {
  final String text;
  const DescSection({
    Key? key, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kLessPadding, horizontal: kFixPadding),
      child:
          Text(text, style: kSubTextStyle),
    );
  }
}