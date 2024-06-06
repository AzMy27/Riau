import 'package:flutter/material.dart';
import 'package:p11_tugas/evaluasi/home.dart';
// import 'package:p11_tugas/zimpanan/Contact.dart';
// import 'package:p11_tugas/zimpanan/Sms.dart';
// import 'package:p11_tugas/zimpanan/Camera.dart';
// import 'package:p11_tugas/zimpanan/Home.dart';
// import 'package:p11_tugas/zimpanan/url_launcher.dart';
// import 'package:p11_tugas/zimpanan/url_launcher.dart';
// import 'package:p11_tugas/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akses Database SQLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
