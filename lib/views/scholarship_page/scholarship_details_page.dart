import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholarshipDetails extends StatefulWidget {
   ScholarshipDetails({Key? key,required this.image,required this.title,required this.website,required this.email,required this.address,required this.description,required this.phone}) : super(key: key);
String image;
String title;
    String description;
    String phone;
    String address;

    String email;
    String website;
  @override
  State<ScholarshipDetails> createState() => _ScholarshipDetailsState();
}

class _ScholarshipDetailsState extends State<ScholarshipDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text("Scholarship Adverts"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            Container(
               child: Image.network(
                    widget.image,
                    height: 250, fit: BoxFit.fill)
            ),
            const SizedBox(height: 10,),
            Text(widget.title,style: const TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
            Text(widget.address),
            Text('Phone : ${widget.phone}'),
            Text('Email Us : ${widget.email}'),
            Text('Website : ${widget.website}'==null?"":widget.website),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.description),
            ),
            const SizedBox(height: 15,),
        Center(
          child: InkWell(
              child: const Text('View More',style: TextStyle(color:Color(0xFF1A8F00) ,fontSize: 15,fontWeight: FontWeight.bold),),
              onTap: () => launch(widget.website)
          ),
        ),const SizedBox(height: 10,)     ,     ],
        ),
      ),
    );
  }
}
