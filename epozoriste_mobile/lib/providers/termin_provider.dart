import 'dart:convert';

import 'package:epozoriste_mobile/providers/base_provider.dart';
import '../models/models.dart';

class TerminProvider extends BaseProvider<Termin> {
  static String? _baseUrl;
  TerminProvider() : super("Termin") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5192/");
  }

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }

  Future<List<Termin>> recommend(int id) async {
    var url = "$_baseUrl" + "Termin/recommend/$id";
    var headers = createHeaders();
    var uri = Uri.parse(url);
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<Termin>().toList();
    }
    throw Exception("Error on the server");
  }
}
