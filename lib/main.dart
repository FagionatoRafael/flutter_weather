// import 'dart:html';
import 'package:climabra/screens/listItens.dart';
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
        '/wather': (context) => const Wather(title: 'Clima'),
        '/listCities': (context) => const ListItens(title: ''),
      },
    );
  }
}
