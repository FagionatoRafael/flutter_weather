import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/api.dart';

class Lista extends StatelessWidget {
  Lista({Key? key}) : super(key: key);

  var id = 0;
  var nomeUf = 'SP';
  var nome = '';
  var id_user = '';

  @override
  Widget build(BuildContext context) {
    dynamic? data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      print(data);
      id = data["id"];
      nomeUf = data["nameUf"];
      if (data["nome"] != null) {
        nome = data["nome"];
      }
      if (data["id_user"] != null) {
        id_user = data["id_user"];
      }
    }
    return Scaffold(body: buildContainer());
  }

  void onPressButton(String name, BuildContext context) {
    if (id == 0) {
      Navigator.pushReplacementNamed(context, '/wather', arguments: {
        "nameCity": name,
        "nameUf": nomeUf,
        "nome": nome,
        "id_user": id_user
      });
    } else {
      Navigator.pushReplacementNamed(context, '/wather',
          arguments: {"nameUf": name, "nome": nome, "id_user": id_user});
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
