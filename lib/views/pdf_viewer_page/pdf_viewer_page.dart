import 'dart:io';

import 'package:educanapp/views/pdf_viewer_page/downloading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:path_provider/path_provider.dart';

class PDFDoc extends StatefulWidget {
  PDFDoc({Key? key, required this.link, required this.title}) : super(key: key);
  String link;
  String title;
  @override
  State<PDFDoc> createState() => _PDFDocState();
}

class _PDFDocState extends State<PDFDoc> {
  void secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    // await FlutterWindowManager.addFlags(
    //     FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  }

  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    secureScreen();
  }

  void sharePressed() {
    String message =
        'Check Out ${widget.title} on the Educan App Library Content\nhttps://play.google.com/store/apps/details?id=com.educan.educanapp&hl=en&gl=US';

        // Share.shareFiles(['${directory.path}assets/images/ic_logo.png'], text: message);
    Share.share(message);

    // optional subject that will be used when sharing via email
    // Share.share(message,subject:'Sharing a Resource from the Best App for all Students');

    // share a file
    // Share.shareFiles(['${directory.path}/images.jpg'],text:widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        // leading: IconButton(onPressed: (){},icon: const Icon(Icons.menu),),
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        actions: [
          // IconButton(onPressed: () async {}, icon: const Icon(Icons.download)),
          IconButton(
              onPressed: () {
                sharePressed();
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: SfPdfViewer.network(widget.link),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _permissionReady = await _checkPermission();
          if (_permissionReady) {
            await _prepareSaveDir();
            showDialog(
              context: context,
              builder: (context) => DownloadingDialog(
                imgUrl: widget.link,
                name: widget.title,
                path: _localPath,
              ),
            );
          }
        },
        tooltip: 'Download Document',
        child: const Icon(Icons.download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
