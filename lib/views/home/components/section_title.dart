import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    this.title,
    this.press,
    this.x,
  }) : super(key: key);

  final String? title;
  final Color? x;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
      decoration: BoxDecoration(
        color: x,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding:const EdgeInsets.only(top: 4,bottom:8),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width: 0.01,),
          Text(
            "   $title!",
            style: const TextStyle(
                fontSize: 13, color: Colors.white,),
          ),
          GestureDetector(
            onTap: press,
            child: const Text(
              "SEE ALL    ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          // SizedBox(width: 0.01,),
        ],
      ),
    ),
    );
  }
}
