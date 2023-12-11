import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class PredstavaProvider extends BaseProvider<Predstava> {
  PredstavaProvider() : super("Predstava");

  @override
  Predstava fromJson(data) {
    return Predstava.fromJson(data);
  }
}
