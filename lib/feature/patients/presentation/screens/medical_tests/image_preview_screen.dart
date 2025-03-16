import 'package:flutter/material.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Center(child: InteractiveViewer(child: Image.asset(imageUrl))),
    );
  }
}
