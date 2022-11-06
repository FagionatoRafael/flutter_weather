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
}
