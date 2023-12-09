import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class ObavijestProvider extends BaseProvider<Obavijest> {
  static String? _baseUrl;
  ObavijestProvider() : super("Obavijest") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5192/");
  }

  @override
  Obavijest fromJson(data) {
    return Obavijest.fromJson(data);
  }
}
