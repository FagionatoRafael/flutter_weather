import 'package:climabra/api/api.dart';
import 'package:climabra/screens/login.dart';
import 'package:climabra/screens/weather.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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

  void onPressButton() async {
    if (nome != '' && senha != '') {
      var res = await API('').getHasUser(nome);
      if (res == null) {
        API('').postUser(nome, senha);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const Login(title: 'isoo'),
        ));
        // print(res);
      } else {
        setState(() {
          error = 'Usuário já existe!';
        });
      }
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
        title: const Text('Signin'),
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
                    fixedSize: const Size(300, 50),
                  ),
                  onPressed: onPressButton,
                  child: const Text('Cadastrar'),
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
