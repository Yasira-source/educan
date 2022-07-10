import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PDFDoc extends StatefulWidget{
   PDFDoc ({Key? key,required this.link,required this.title}):super(key: key);
String link;
String title;
  @override
  State<PDFDoc> createState()   => _PDFDocState();
}

class _PDFDocState extends State<PDFDoc>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
appBar: AppBar(
  backgroundColor: const Color(0xFF1A8F00),
  // leading: IconButton(onPressed: (){},icon: const Icon(Icons.menu),),
  title:  Text(widget.title,overflow: TextOverflow.ellipsis,maxLines: 1,),

),
      body: Container(
        child: SfPdfViewer.network(widget.link),
      ),
    );
  }
}
