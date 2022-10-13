import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  String nome;
  String baseUrlCity = '';
  String token = "5765cda0";

  API(this.nome);

  Future getWeatherByCity() async {
    var url =
        "https://api.hgbrasil.com/weather?format=json-cors&key=$token&city_name=$nome";
    print(url);
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    return jsonDecode(response.body);
  }
}
