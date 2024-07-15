import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class PdfState with ChangeNotifier {
  PdfState(String path) {
    _initPdfController(path);
  }

  PdfControllerPinch? pdfControllerPinch;

  void _initPdfController(String path) async {

    // final dir = await getApplicationDocumentsDirectory();
    // final file = '${dir.path}/teste';

      pdfControllerPinch = PdfControllerPinch(
        document: PdfDocument.openFile(
          path,
        ),
      );
      notifyListeners();
  }
}
