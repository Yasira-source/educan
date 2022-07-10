import 'package:educanapp/views/home/components/discount_banner.dart';
import 'package:educanapp/views/products_list_page/products_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/cart_controller.dart';
import 'categories.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {

  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String _pname = '';
  String upname = '';
  String uid = '';

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');
      _pname = (prefs.getString('username') ?? '');
      final x = _pname.split(" ");
      upname = x[0];
    });
  }
  @override
  Widget build(BuildContext context) {
    String greet = greeting();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.white,
              child: Column(

                children: [
                  const SizedBox(height: 10),
                  Text(
                    "$greet $upname!",
                    style: const TextStyle(
                        color: Color(0xFF1A8F00),
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                   HomeHeader(uid: uid,),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            // const SizedBox(height: 1),
            const Text(
              "What do you need?",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            // const SizedBox(height: 2),

            Categories(),
            const DiscountBanner(),

            // SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts("BOOKSHOP & MORE", 0088, Color(0xfffc0f03),"Book","ASC"),
            // SizedBox(height: 5),
            const SpecialOffers(),
            const SizedBox(height: 20),

            // MySlider(),

            PopularProducts("STATIONERY & OFFICE", 1, const Color(0xff221d75),"","ASC"),
            const SizedBox(height: 30),

            PopularProducts("BACK TO SCHOOL ITEMS", 2, const Color(0xff790eeb),"","ASC"),
            const SizedBox(height: 30),
            // SpecialOffers(),

            PopularProducts("SCHOOL TECH GADGETS", 3, Color(0xffeb0ed5),"","ASC"),
            const SizedBox(height: 30),

            PopularProducts("TOYS, GAMES, & MORE", 4, Color(0xffeb490e),"","ASC"),
            const SizedBox(height: 30),
            // SpecialOffers(),

            PopularProducts("GIFTS, AWARDS & BRANDING", 5, Color(0xff141414),"","ASC"),
            const SizedBox(height: 30),

            PopularProducts("SCHOOL UNIFORMS & MORE", 6, Color(0xfff5bb0c),"","ASC"),
            const SizedBox(height: 30),
            // SpecialOffers(),

            PopularProducts("LAB EQUIPMENTS", 7, Color(0xff0d780f),"","ASC"),
            const SizedBox(height: 30),

            PopularProducts("PRINTING & PUBLISHING", 8, Color(0xff0d7478),"","ASC"),
            const SizedBox(height: 30),
            // SpecialOffers(),

            PopularProducts("CO-CURRICULAR ITEMS", 9, Color(0xff4b0d78),"","ASC"),
            const SizedBox(height: 30),

            PopularProducts("BEST I.T SERVICES", 10, Color(0xff780d51),"","ASC"),
            const SizedBox(height: 30),

            PopularProducts("OFFICIAL STORES", 00, Color(0xff780d16),"","ASC"),
            const SizedBox(height: 30),

            // SpecialOffers(),
          ],
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    }
    if (hour < 17) {
      return 'Good Afternoon,';
    }
    return 'Good Evening,';
  }
}
