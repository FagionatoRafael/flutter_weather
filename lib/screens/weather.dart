import 'dart:convert';
import 'dart:convert';
// import 'dart:html';
import 'package:climabra/api/api.dart';
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
  String nomeCity = 'Araçatuba';
  String nomeUf = 'SP';
  String nome = '';
  String id_user = '';
  String climaMax = '';
  String climaMin = '';
  String climaNow = '';
  String error = '';
  List<dynamic> itens = [];

  @override
  void initState() {
    super.initState();
  }

  void onPressButton() async {
    if (nomeCity != '') {
      var res = await API(nomeCity).getWeatherByCity();
      if (res['results']['city_name'] == nomeCity) {
        print(res['results']['temp']);
        setState(() {
          climaNow = "${res['results']['temp'].toString()}C°";
          climaMax =
              "Max: ${res['results']['forecast'][0]['max'].toString()}C°";
          climaMin =
              "Min: ${res['results']['forecast'][0]['min'].toString()}C°";
          error = '';
        });
        API('').updateCidades(id_user, nomeCity);
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

  void navigateToHistorico() {
    Navigator.pushReplacementNamed(context, '/listHis',
        arguments: {"nome": nome, "id_user": id_user});
  }

  void navigateToList(id) {
    Navigator.pushReplacementNamed(context, '/list', arguments: {
      "id": id,
      "nameUf": nomeUf,
      "nome": nome,
      "id_user": id_user
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic? data = ModalRoute.of(context)?.settings.arguments;
    // String name = "Araçatuba";
    if (data != null) {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        if (data["id_user"] != null) {
          id_user = data["id_user"];
        }
        if (data["nome"] != null) {
          nome = data["nome"];
        }
        if (data["nameCity"] != null) {
          nomeCity = data["nameCity"];
        }
        if (data["nameUf"] != null) {
          nomeUf = data["nameUf"];
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.account_box_rounded,
                            color: Colors.pink,
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                          Text(nome),
                          OutlinedButton(
                            onPressed: navigateToHistorico,
                            child: const Text('Histórico'),
                          ),
                          // OutlinedButton(
                          //   onPressed: onPressButton,
                          //   child: Text('Excluir'),
                          // )
                        ],
                      ),
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Text(climaNow),
              ),
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
                  onTap: () => navigateToList(1),
                  onChanged: (value) => {},
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: nomeUf,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  obscureText: true,
                  onTap: () => navigateToList(0),
                  onChanged: (value) => {},
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: nomeCity,
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
