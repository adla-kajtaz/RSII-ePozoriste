import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class ObavijestProvider extends BaseProvider<Obavijest> {
  ObavijestProvider() : super("Obavijest");

  @override
  Obavijest fromJson(data) {
    return Obavijest.fromJson(data);
  }
}
