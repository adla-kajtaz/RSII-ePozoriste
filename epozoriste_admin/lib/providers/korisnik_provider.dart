import 'dart:convert';
import '../models/korisnik.dart';
import 'base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  static String? _baseUrl;
  KorisnikProvider() : super("Korisnik") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5192/");
  }

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

  Future<Korisnik?> getUser(int id) async {
    var url = "$_baseUrl" + "Korisnik/$id";
    var headers = createHeaders();
    var uri = Uri.parse(url);
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    }
    return null;
  }

  Future<Korisnik?> updateProfile(int? id, dynamic request) async {
    var url = "$_baseUrl" + "Korisnik/$id";
    var headers = createHeaders();
    var uri = Uri.parse(url);
    var jsonRequest = jsonEncode(request);
    var response = await http!.put(uri, headers: headers, body: jsonRequest);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else if (response.statusCode == 400) {
      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        throw Exception("Bad request ${data["error"].toString()}");
      }
      throw Exception('Bad request');
    }
    return null;
  }
}
