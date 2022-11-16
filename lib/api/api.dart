import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class API {
  String nome;
  String baseUrlCity = '';
  String? token = dotenv.env['TOKEN_API'];

  API(this.nome);

  Future getWeatherByCity() async {
    var client = http.Client();
    var url =
        "https://api.hgbrasil.com/weather?format=json-cors&key=$token&city_name=$nome";
    var response = await client.get(Uri.parse(url));
    print(url);
    print(response.statusCode);
    client.close();
    return jsonDecode(response.body);
  }

  Future getUfs() async {
    var client = http.Client();
    var url =
        "https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome";
    var response = await client.get(Uri.parse(url));
    print(response.statusCode);
    client.close();
    return jsonDecode(response.body);
  }

  Future getCities(uf) async {
    var client = http.Client();
    var url =
        "https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios?orderBy=nome";
    var response = await client.get(Uri.parse(url));
    print(response.statusCode);
    client.close();
    return jsonDecode(response.body);
  }

  Future getAuthUser(nome, senha) async {
    var client = http.Client();
    var url = "https://aps-app-show.herokuapp.com/user/auth";
    var response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'nome': nome, 'senha': senha}),
    );
    client.close();
    if (response.body != '') {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future getHasUser(nome) async {
    var client = http.Client();
    var url = "https://aps-app-show.herokuapp.com/hasUser";
    var response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'nome': nome}),
    );
    client.close();
    print(response.body);
    if (response.body != '') {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future postUser(nome, senha) async {
    var client = http.Client();
    var url = "https://aps-app-show.herokuapp.com/user";
    var response = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'nome': nome, 'senha': senha}),
    );
    client.close();
    if (response.body != '') {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future updateCidades(id, cidade) async {
    var client = http.Client();
    var url = "https://aps-app-show.herokuapp.com/user/$id";
    var response = await client.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'cidade': cidade}),
    );
    client.close();
    if (response.body != '') {
      return jsonDecode(response.body);
    }
    return null;
  }
}
