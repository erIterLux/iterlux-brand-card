import 'package:flutter/material.dart';
import 'package:iterlux_brand_card/services/firebase_auth_service.dart';
import 'package:iterlux_brand_card/services/qr_code_data_service.dart';
import 'package:sqflite/sqflite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseAuthService? _authService;

  @override
  void initState() {
    super.initState();
    _initAuthService();
  }

  Future<void> _initAuthService() async {
    final database = await openDatabase('qrcodes.db');
    _authService = FirebaseAuthService(QrCodeDataService(database));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            ElevatedButton(onPressed: _register, child: const Text('Register')),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_authService == null) return; // Guard if not initialized
    await _authService!.login(_emailController.text, _passwordController.text);
    Navigator.pushReplacementNamed(context, '/main');
  }

  Future<void> _register() async {
    if (_authService == null) return;
    await _authService!.register(_emailController.text, _passwordController.text);
  }
}