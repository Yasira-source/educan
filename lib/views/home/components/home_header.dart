
import 'package:educanapp/views/cart/cart_screen.dart';
import 'package:flutter/material.dart';

import '../../cart/cart.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
   HomeHeader({
    Key? key,required this.uid
  }) : super(key: key);
String uid;


  @override
  Widget build(BuildContext context) {
    return   Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SearchField(),
              const SizedBox(width: 5,),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",

                press: () =>{
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartScreen(
                )))
                },
              ),
              // IconBtnWithCounter(
              //   svgSrc: "assets/icons/Bell.svg",
              //   numOfitem: 3,
              //   press: () {},
              // ),
            ],
          ),

    );
  }
}
