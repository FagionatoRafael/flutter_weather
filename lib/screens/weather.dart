import 'dart:convert';
import 'dart:convert';
import 'dart:html';
import 'package:flu/api/api.dart';
import 'package:flutter/material.dart';

class City {
  var id;
  var name;
  var state;
  var country;
}

class Wather extends StatefulWidget {
  const Wather({Key? key, required this.title}) : super(key: key);

  final String title;
  final String nome = '';

  @override
  State<Wather> createState() => _WatherState();
}

class _WatherState extends State<Wather> {
  String nome = '';
  String climaMax = '';
  String climaMin = '';
  String error = '';

  void onChangeName(String value) {
    setState(() {
      nome = value;
    });
  }

  void onPressButton() async {
    if (nome != '') {
      var res = await API(nome).getWeatherByCity();
      if (res['results']['city_name'] == nome) {
        setState(() {
          climaMax = "Max: ${res['results']['forecast'][0]['max'].toString()}C";
          climaMin = "Min: ${res['results']['forecast'][0]['min'].toString()}C";
          error = '';
        });
      } else {
        setState(() {
          climaMax = '';
          climaMin = '';
          error = 'Erro na validação do nome da cidade';
        });
      }
    } else {
      setState(() {
        climaMax = '';
        climaMin = '';
        error = 'Insira um valor no campo';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('algum texto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(climaMin),
                Text(climaMax),
              ],
            ),
            TextField(
              obscureText: false,
              onChanged: (value) => onChangeName(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome da cidade',
              ),
            ),
            OutlinedButton(
              onPressed: onPressButton,
              child: const Text('Buscar'),
            ),
            Text(error),
          ],
        ),
      ),
    );
  }
}
