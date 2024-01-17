import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelView extends StatefulWidget {
  String url = '';
  ModelView({Key? key, required this.url}) : super(key: key);

  @override
  State<ModelView> createState() => _ModelViewState();
}

class _ModelViewState extends State<ModelView> {
  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      // backgroundColor: Get.isDarkMode?Colors.:Colors.white12,
      src: widget.url, // a bundled asset file
      ar: true,
      arModes: const ['scene-viewer', 'webxr', 'quick-look'],
      autoRotate: true,
      cameraControls: true,
      iosSrc: widget.url,
    );
  }
}
