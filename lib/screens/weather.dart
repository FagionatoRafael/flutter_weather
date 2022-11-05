import 'dart:convert';
// import 'package:http/http.dart' as http;
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
  String _dropdownValue = "Adamantina";
  List<String> itens = [];

  @override
  void initState() {
    super.initState();
    // buildDropdown();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //    Future.delayed(Duration(seconds: 3), () => yourFunction());
    // });
  }

  void dropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  void buildDropdown() async {
    var res1 = await API('').getCities();
    for (var el in res1) {
      setState(() {
        _dropdownValue = res1[0]['nome'];
        if (el['nome'] != null &&
            el['nome'] != '' &&
            res1[0]['nome'] != el['nome']) {
          itens.add(el['nome'].toString());
        }
      });
    }
    print(itens);
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
    Object? data = ModalRoute.of(context)?.settings.arguments;
    // if(!data != null) {
    //   String name = data?.name;
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('algum texto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(climaMin),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(climaMax),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) => {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'aloo',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(300, 50),
                  ),
                  onPressed: onPressButton,
                  child: const Text('Buscar'),
                ),
              ),
              Text(error),
            ],
          ),
        ),
      ),
    );
  }
}
