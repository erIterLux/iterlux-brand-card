import 'package:firebase_auth/firebase_auth.dart';
import 'package:iterlux_brand_card/services/qr_code_data_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final QrCodeDataService _qrCodeDataService;

  FirebaseAuthService(this._qrCodeDataService);

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _onLoginSuccess();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> _onLoginSuccess() async {
    await _qrCodeDataService.syncQrCodes();
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  bool isUserLoggedIn() => _auth.currentUser != null;

  String? getUserId() => _auth.currentUser?.uid;

  Future<void> signOut() async => await _auth.signOut();
}