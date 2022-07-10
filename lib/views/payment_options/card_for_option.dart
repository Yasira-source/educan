import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.text,
    required this.text2,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon,text2;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Image.asset(
              icon,
              // color: Colors.black,
              width: 50,
              height: 50,
              fit:BoxFit.cover
            ),
            const SizedBox(width: 20),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[

            Text(text,textAlign: TextAlign.start,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text(text2,style: const TextStyle(fontSize: 15))
                ]
            )
            ),
            const Icon(Icons.arrow_forward_ios,color: Color(0xFF1A8F00),),
          ],
        ),
      ),
    );
  }
}
