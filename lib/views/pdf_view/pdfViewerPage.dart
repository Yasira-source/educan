import 'package:educanapp/views/pdf_view/ApiServiceProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? localPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiServiceProvider.loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CodingBoot Flutter PDF Viewer",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
