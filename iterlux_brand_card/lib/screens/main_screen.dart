import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iterlux_brand_card/providers/qr_code_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QrCodeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Main QR Code')),
      body: Center(
        child: provider.defaultQrCode != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(File(provider.defaultQrCode!.filePath), height: 200, width: 200),
                  Text(provider.defaultQrCode!.name),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/manageqr'),
                    child: const Text('Manage QR Codes'),
                  ),
                ],
              )
            : const Text('No default QR Code set. Please manage your QR codes.'),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Main'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Manage'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
      ],
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) Navigator.pushNamed(context, '/manageqr');
        if (index == 2) Navigator.pushNamed(context, '/about');
      },
    );
  }
}