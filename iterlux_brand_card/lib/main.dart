import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iterlux_brand_card/providers/theme_provider.dart';
import 'package:iterlux_brand_card/providers/qr_code_provider.dart';
import 'package:iterlux_brand_card/screens/main_screen.dart';
import 'package:iterlux_brand_card/screens/manage_qr_codes_screen.dart';
import 'package:iterlux_brand_card/screens/about_screen.dart';
import 'package:iterlux_brand_card/screens/login_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:iterlux_brand_card/services/qr_code_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  // Initialize SQLite database
  final databasesPath = await getDatabasesPath();
  final dbPath = path.join(databasesPath, 'qrcodes.db');
  final database = await openDatabase(dbPath, version: 1,
      onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS qrcodes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        filePath TEXT,
        storageUrl TEXT,
        isDefault INTEGER DEFAULT 0,
        lastUpdated TEXT,
        userId TEXT,
        needsUpload INTEGER DEFAULT 0,
        needsRename INTEGER DEFAULT 0
      )
    ''');
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QrCodeProvider(QrCodeDataService(database))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Iterlux Smart Card',
      theme: themeProvider.themeData,
      initialRoute: '/login', // Start at login if needed
      routes: {
        '/main': (_) => const MainScreen(),
        '/manageqr': (_) => const ManageQrCodesScreen(),
        '/about': (_) => const AboutScreen(),
        '/login': (_) => const LoginScreen(),
      },
    );
  }
}