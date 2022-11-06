import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/api.dart';

class Lista extends StatelessWidget {
  Lista({Key? key}) : super(key: key);

  var id = 0;
  var nomeUf = 'SP';

  @override
  Widget build(BuildContext context) {
    dynamic? data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      print(data);
      id = data["id"];
      nomeUf = data["nameUf"];
    }
    return Scaffold(body: buildContainer());
  }

  void onPressButton(String name, BuildContext context) {
    if (id == 0) {
      Navigator.pushReplacementNamed(context, '/wather',
          arguments: {"nameCity": name, "nameUf": nomeUf});
    } else {
      Navigator.pushReplacementNamed(context, '/wather',
          arguments: {"nameUf": name});
    }
    print(name);
  }

  buildContainer() {
    return Center(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: getFutureDados(),
            builder: (context, dynamic snapshot) {
              List? snap = snapshot.data;
              if (snapshot.hasData && snap != null) {
                return Column(
                  children: snap.map<Widget>((dynamic items) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(300, 50),
                        ),
                        onPressed: () => onPressButton(
                            items[id == 0 ? 'nome' : 'sigla'], context),
                        child: Text(items[id == 0 ? 'nome' : 'sigla']),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Future<Object> getFutureDados() async {
    var res;
    if (id == 0) {
      res = await API('').getCities(nomeUf);
    } else if (id == 1) {
      res = await API('').getUfs();
    }
    return res;
  }
}
