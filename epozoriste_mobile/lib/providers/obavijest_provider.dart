import 'package:epozoriste_mobile/providers/base_provider.dart';
import '../models/models.dart';

class ObavijestProvider extends BaseProvider<Obavijest> {
  static String? _baseUrl;
  ObavijestProvider() : super("Obavijest") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5192/");
  }

  @override
  Obavijest fromJson(data) {
    return Obavijest.fromJson(data);
  }
}
