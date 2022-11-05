import 'package:climabra/screens/weather.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';

class ListItens extends StatefulWidget {
  const ListItens({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListItens> createState() => _ListItensState();
}

class _ListItensState extends State<ListItens> {
  List<String> itens = [];
  int id = 0;
  String nomeUf = 'SP';

  @override
  void initState() {
    super.initState();
  }

  void buildDropdown() async {
    dynamic? data = ModalRoute.of(context)?.settings.arguments;
    var res1;
    if (id == 0) {
      res1 = await API('').getCities(nomeUf);
      for (var el in res1) {
        setState(() {
          // _dropdownValue = res1[0]['nome'];
          if (el['nome'] != null &&
              el['nome'] != '' &&
              res1[0]['nome'] != el['nome']) {
            itens.add(el['nome']);
          }
        });
        // print(el['nome']);
      }
    } else {
      res1 = await API('').getUfs();
      for (var el in res1) {
        setState(() {
          // _dropdownValue = res1[0]['nome'];
          if (el['sigla'] != null &&
              el['sigla'] != '' &&
              res1[0]['sigla'] != el['sigla']) {
            itens.add(el['sigla']);
          }
        });
        // print(el['sigla']);
      }
    }
  }

  void onPressButton(String name) {
    if (id == 0) {
      Navigator.pushReplacementNamed(context, '/wather',
          arguments: {"nameCity": name, "nameUf": nomeUf});
    } else {
      Navigator.pushReplacementNamed(context, '/wather',
          arguments: {"nameUf": name});
    }
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    dynamic? data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      print(data);
      setState(() {
        id = data["id"];
        nomeUf = data["nameUf"];
      });
      buildDropdown();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itens.map((String items) {
                return Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(300, 50),
                    ),
                    onPressed: () => onPressButton(items),
                    child: Text(items),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
