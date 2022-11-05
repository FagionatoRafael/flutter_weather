import 'package:climabra/screens/weather.dart';
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
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  obscureText: false,
                  onChanged: (value) => onChangeName(value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) => onChangePass(value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
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
                  child: const Text('Entrar'),
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
