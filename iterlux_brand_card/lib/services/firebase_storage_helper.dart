import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iterlux_brand_card/models/qr_code.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FirebaseStorageHelper {
  static Future<(bool, String?, DateTime?, String?)> uploadFile(String filePath, String fileName) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? 'UnknownUser';
      final ref = FirebaseStorage.instance.ref('users/$userId/qrCodes/$fileName');
      await ref.putFile(File(filePath));
      final metadata = await ref.getMetadata();
      final downloadUrl = await ref.getDownloadURL();
      return (true, downloadUrl.toString(), metadata.updated, null);
    } catch (e) {
      return (false, null, null, e.toString());
    }
  }

  static Future<(bool, String?)> deleteFile(String storageUrl) async {
    try {
      await FirebaseStorage.instance.refFromURL(storageUrl).delete();
      return (true, null);
    } catch (e) {
      return (false, e.toString());
    }
  }

  static Future<(bool, String?, DateTime?, String?)> downloadFile(String storageUrl, String destinationPath) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(storageUrl);
      final metadata = await ref.getMetadata();
      final dir = path.dirname(destinationPath);
      if (!await Directory(dir).exists()) await Directory(dir).create(recursive: true);
      if (await File(destinationPath).exists()) {
        final localLastModified = await File(destinationPath).lastModified();
        if (localLastModified.isAfter(metadata.updated ?? DateTime.now())) return (true, destinationPath, metadata.updated, null);
      }
      await ref.writeToFile(File(destinationPath));
      return (true, destinationPath, metadata.updated, null);
    } catch (e) {
      return (false, null, null, e.toString());
    }
  }

  static Future<List<QrCode>> getRemoteQrCodes(Reference ref) async {
    final qrCodes = <QrCode>[];
    final result = await ref.listAll();
    for (var item in result.items) {
      final metadata = await item.getMetadata();
      qrCodes.add(QrCode(
        name: metadata.name.split('.').first,
        storageUrl: (await item.getDownloadURL()).toString(),
        lastUpdated: metadata.updated ?? DateTime.now().toUtc(),
      ));
    }
    return qrCodes;
  }

  // Add metadata fetch, retry logic as needed
}