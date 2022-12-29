import 'package:educanapp/views/classes_page/classes_page.dart';
import 'package:educanapp/views/classes_page/classes_page_2.dart';
import 'package:educanapp/views/features/presentation/pages/portfolio/portfolio_tutorials_sub_page.dart';
import 'package:educanapp/views/home/components/wallet_auth_page.dart';
import 'package:educanapp/views/pdf_view/pdfViewerPage.dart';
import 'package:educanapp/views/pdf_viewer_page/pdf_viewer_page.dart';
import 'package:educanapp/views/scholarship_page/scholarship_page.dart';
import 'package:educanapp/views/subscription_page/subscription_page.dart';
import 'package:flutter/material.dart';

import '../../edu_talk/pages/portfolio/portfolio_tutorials_sub_page.dart';
import '../../order_lesson/order_lesson.dart';
import '../../subscription_page/wallet_details_page.dart';


class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
 
       {"icon": "assets/images/ed_online_class.png", "text": "Lessons","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClassesPage(title: "Educan Lessons",catid: 1,)));
              }},
      {"icon": "assets/images/ed_book_shelf.png", "text": "Library","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClassesPage(title: "Educan Library",catid: 2,)));
              }},
      {"icon": "assets/images/ed_ask_teacher.png", "text": "Consult","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClassesPageSecond(title: "Consultation", catid: 4)));
              }},
       {"icon": "assets/images/ed_oreder.png", "text": "Order Lesson","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderLesson()));
              }},

    ];

     List<Map<String, dynamic>> categories2 = [
      {"icon": "assets/images/ed_library.png", "text": "Tr. Resources","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClassesPage(title: "Teacher Resources",catid: 3,)));
              }},
      {"icon": "assets/images/ed_scholarship.png", "text": "Scholarships","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScholarshipPage()));
              }},

      {"icon": "assets/images/ed_edutalk.png", "text": "Educan Talk","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EduTalkTutorialsSubPage()));
              }},

      {"icon": "assets/images/ed_subscribe.png", "text": "Subscription","press":() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WalletAuth()));
              }},

    ];
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Container(
        // color: Colors.white70,
        child: Column(
          children: [
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              press:  categories[index]['press'],
            ),
          ),
        ),
        SizedBox(height: 3,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories2.length,
            (index) => CategoryCard(
              icon: categories2[index]["icon"],
              text: categories2[index]["text"],
              press: categories2[index]["press"],
            ),
          ),
        )
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
     this.icon,
     this.text,
     this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 50,
              width: 75,
              decoration: BoxDecoration(
                // color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: Color(0xFF1A8F00)),maxLines: 2,)
          ],
        ),
      ),
    );
  }
}
