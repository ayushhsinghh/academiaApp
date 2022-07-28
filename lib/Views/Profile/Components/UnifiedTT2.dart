import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class UnifiedTT2 extends StatelessWidget {
  const UnifiedTT2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransformationController controller = TransformationController();
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue.shade100,
        title: const Text("Batch 2", style: TextStyle(color: Colors.black)),
      ),
      body: PhotoView(
        filterQuality: FilterQuality.high,
        backgroundDecoration: BoxDecoration(
          color: Colors.blue.shade100,
        ),
        minScale: PhotoViewComputedScale.contained * 0.6,
        maxScale: PhotoViewComputedScale.covered * 1.3,
        imageProvider: const AssetImage("assets/images/Batch2.PNG"),
      ),
    );
  }
}
