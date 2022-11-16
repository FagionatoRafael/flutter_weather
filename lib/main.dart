// import 'dart:html';
import 'package:climabra/screens/listHis.dart';
import 'package:climabra/screens/listItem.dart';
import 'package:climabra/screens/signin.dart';
import 'package:climabra/screens/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:climabra/screens/login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(
        title: '',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(title: 'alo'),
        '/wather': (context) => const Wather(title: 'Clima'),
        '/list': (context) => Lista(),
        '/listHis': (context) => ListaHis(),
        '/signin': (context) => const Signin(title: 'alo')
      },
    );
  }
}
