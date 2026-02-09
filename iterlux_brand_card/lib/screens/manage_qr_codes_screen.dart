import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iterlux_brand_card/providers/qr_code_provider.dart';
import 'package:iterlux_brand_card/models/qr_code.dart';
import 'package:iterlux_brand_card/widgets/qr_code_popup.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ManageQrCodesScreen extends StatelessWidget {
  const ManageQrCodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QrCodeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Manage QR Codes')),
      body: provider.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.qrCodes.length,
              itemBuilder: (ctx, index) {
                final qr = provider.qrCodes[index];
                return ListTile(
                  leading: GestureDetector(
                    onTap: () => showDialog(context: context, builder: (_) => QrCodePopup(qr.filePath)),
                    child: Image.file(File(qr.filePath), height: 100, width: 100),
                  ),
                  title: TextField(
                    controller: TextEditingController(text: qr.name),
                    onSubmitted: (newName) {
                      qr.name = newName;
                      provider.addQrCode(qr); // Save on submit
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: qr.isDefault ? null : () => provider.setDefaultQrCode(qr),
                        child: const Text('Set Default'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => provider.deleteQrCode(qr),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addQrCode(context, provider),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addQrCode(BuildContext context, QrCodeProvider provider) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${Uuid().v4()}.${pickedFile.path.split('.').last}';
      final destination = '${appDir.path}/$fileName';
      await File(pickedFile.path).copy(destination);
      final qrCode = QrCode(
        name: fileName.split('.').first,
        filePath: destination,
        lastUpdated: DateTime.now(),
        needsUpload: true,
      );
      // Upload to Firebase (implement full logic)
      await provider.addQrCode(qrCode);
    }
  }
}