import 'dart:io';
import 'package:flutter/material.dart';

class QrCodePopup extends StatelessWidget {
  final String imagePath;

  const QrCodePopup(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Image.file(File(imagePath), height: 250, width: 250),
    );
  }
}