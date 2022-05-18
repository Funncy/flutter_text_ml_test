import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextMl extends StatefulWidget {
  const TextMl({Key? key}) : super(key: key);

  @override
  State<TextMl> createState() => _TextMlState();
}

class _TextMlState extends State<TextMl> {
  XFile? image;

  void Photo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    setState(() {
      image = pickedImage;
    });
  }

  void getText() async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);
    if (image == null) return;
    final File file = File(image!.path);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(children: [
          Text("Image 인식"),
          if (image != null) Image.file(File(image!.path))
        ]),
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.camera),
              onPressed: () {
                Photo();
              }),
          FloatingActionButton(
              child: const Icon(Icons.analytics),
              onPressed: () {
                getText();
              }),
        ],
      ),
    );
  }
}
