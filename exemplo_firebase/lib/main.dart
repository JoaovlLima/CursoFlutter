import 'package:exemplo_firebase/firebase_options.dart';
import 'package:exemplo_firebase/screens/home-sreen.dart';
import 'package:exemplo_firebase/screens/list_screen.dart';
import 'package:exemplo_firebase/screens/login-sreen.dart';
import 'package:exemplo_firebase/screens/registro-sreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Exemplo FireBase",
      home: const HomeScreen(),
      routes: {
        '/home':(context) => const HomeScreen(),
        '/login':(context) => const LoginPage(),
        '/registro':(context) => const RegistroScreen(),
        
      },
    );
  }
}
