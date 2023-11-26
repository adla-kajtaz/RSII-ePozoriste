import 'dart:convert';
import '../models/kupovina.dart';
import 'base_provider.dart';

class KupovinaProvider extends BaseProvider<Kupovina> {
  static String? _baseUrl;
  KupovinaProvider() : super("Kupovina") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5192/");
  }

  @override
  Kupovina fromJson(data) {
    return Kupovina.fromJson(data);
  }

  Future<List<Kupovina>> getByKorisnikId(int id) async {
    var url = "$_baseUrl" + "Kupovina/getByKorisnikId/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => Kupovina.fromJson(x)).cast<Kupovina>().toList();
    } else {
      throw Exception("Something went wrong");
    }
  }
}
