import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/api.dart';

class ListaHis extends StatelessWidget {
  ListaHis({Key? key}) : super(key: key);

  String nome = "";
  String id_user = "";

  @override
  Widget build(BuildContext context) {
    dynamic? data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      if (data["nome"] != null) {
        nome = data["nome"];
      }
      if (data["id_user"] != null) {
        id_user = data["id_user"];
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Histórico'),
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/wather',
                  arguments: {"nome": nome, "id_user": id_user});
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: buildContainer());
  }

  void onPressButton(String name, BuildContext context) {}

  buildContainer() {
    return Center(
      child: Column(
        children: [
          const Text('Historico'),
          SingleChildScrollView(
            child: FutureBuilder(
                future: getFutureDados(),
                builder: (context, dynamic snapshot) {
                  List? snap = snapshot.data;
                  if (snapshot.hasData && snap != null) {
                    print(snap);
                    // return Text('alo');
                    return Column(
                      children: snap.map<Widget>((dynamic items) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size(300, 50),
                            ),
                            onPressed: () {
                              print('alo');
                            },
                            child: Text(items),
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
        ],
      ),
    );
  }

  Future<Object> getFutureDados() async {
    var res = await API('').getHasUser(nome);
    return res['cidades'];
  }
}
