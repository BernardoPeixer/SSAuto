import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';

import '../states/pdf_state.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({super.key});

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as String;

    return ChangeNotifierProvider(
      create: (context) => PdfState(args),
      child: Consumer<PdfState>(builder: (_, state, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'PDF Viewer',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
          body: _buildUi(state.pdfControllerPinch),
        );
      }),
    );
  }

  Widget _buildUi(controller) {
    return Column(
      children: [
        _pdfView(controller),
      ],
    );
  }
  
  Widget _pdfView(controller) {
    return Expanded(child: PdfViewPinch(controller: controller));
  }
}
