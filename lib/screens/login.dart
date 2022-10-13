import 'package:flu/screens/weather.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String nome = '';
  String senha = '';
  String error = '';

  void onChangeName(String value) {
    setState(() {
      nome = value;
    });
  }

  void onChangePass(String value) {
    setState(() {
      senha = value;
    });
  }

  void onPressButton() {
    if (nome != '' && senha != '') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const Wather(title: 'isoo'),
      ));
    } else {
      setState(() {
        error = 'Erro na validação';
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
          children: <Widget>[
            TextField(
              obscureText: false,
              onChanged: (value) => onChangeName(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
            TextField(
              obscureText: true,
              onChanged: (value) => onChangePass(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
            ),
            OutlinedButton(
              onPressed: onPressButton,
              child: const Text('Entrar'),
            ),
            Text(error),
          ],
        ),
      ),
    );
  }
}
