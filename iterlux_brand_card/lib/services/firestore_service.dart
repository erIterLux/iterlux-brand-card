import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iterlux_brand_card/models/qr_code.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _projectId; // Set your Firestore project ID

  FirestoreService(this._projectId);

  static Future<FirestoreService> create(String projectId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('No authenticated user');
    return FirestoreService(projectId);
  }

  Future<void> saveQrCode(QrCode qrCode) async {
    try {
      final collection = _firestore.collection('qrCodes');
      final docRef = qrCode.id != null ? collection.doc(qrCode.id.toString()) : collection.doc();
      await docRef.set(qrCode.toMap());
    } catch (e) {
      throw Exception('Error saving QR Code: $e');
    }
  }

  Future<List<QrCode>> getQrCodesByUser(String userId) async {
    try {
      final query = _firestore.collection('qrCodes').where('userId', isEqualTo: userId);
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => QrCode.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error fetching QR Codes: $e');
    }
  }

  Future<void> deleteQrCode(String documentId) async {
    try {
      await _firestore.collection('qrCodes').doc(documentId).delete();
    } catch (e) {
      throw Exception('Error deleting QR Code: $e');
    }
  }
}