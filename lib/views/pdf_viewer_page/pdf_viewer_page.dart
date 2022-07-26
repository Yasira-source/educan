import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PDFDoc extends StatefulWidget{
   PDFDoc ({Key? key,required this.link,required this.title}):super(key: key);
String link;
String title;
  @override
  State<PDFDoc> createState()   => _PDFDocState();
}

class _PDFDocState extends State<PDFDoc>{
  void secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    // await FlutterWindowManager.addFlags(
    //     FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  }

  @override
  void initState() {
    super.initState();
    secureScreen();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
appBar: AppBar(
  backgroundColor: const Color(0xFF1A8F00),
  // leading: IconButton(onPressed: (){},icon: const Icon(Icons.menu),),
  title:  Text(widget.title,overflow: TextOverflow.ellipsis,maxLines: 1,),

),
      body: SfPdfViewer.network(widget.link),
    );
  }
}
