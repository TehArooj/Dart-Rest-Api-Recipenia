//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:rest_api/pages/homepage.dart';
import 'package:rest_api/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/models/userstate.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => UserModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Login(),
      routes: {
        "/login": (_) => const Login(),
        "/homepage": (_) => HomePage(),
      },
    );
  }
}
