import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class DrzavaProvider extends BaseProvider<Drzava> {
  DrzavaProvider() : super("Drzava");

  @override
  Drzava fromJson(data) {
    return Drzava.fromJson(data);
  }
}
