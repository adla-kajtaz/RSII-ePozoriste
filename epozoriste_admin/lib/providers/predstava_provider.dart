import 'dart:convert';

import 'package:epozoriste_admin/models/zarada.dart';
import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class PredstavaProvider extends BaseProvider<Predstava> {
  static String? _baseUrl;
  PredstavaProvider() : super("Predstava") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5192/");
  }

  @override
  Predstava fromJson(data) {
    return Predstava.fromJson(data);
  }

  Future<Zarada> getZarada(int id) async {
    var url = "${_baseUrl}Predstava/zaradaReport/$id";
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return Zarada.fromJson(data);
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
