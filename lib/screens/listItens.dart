import 'package:flu/screens/weather.dart';
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

  @override
  void initState() {
    super.initState();
    buildDropdown();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //    Future.delayed(Duration(seconds: 3), () => yourFunction());
    // });
  }

  void buildDropdown() async {
    var res1 = await API('').getCities();
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
  }

  void onPressButton(String name) {
    Navigator.pushReplacementNamed(context, '/wather',
        arguments: {"name": name});
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    // buildDropdown();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
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
