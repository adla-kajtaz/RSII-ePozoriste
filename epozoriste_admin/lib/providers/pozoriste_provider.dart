import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class PozoristeProvider extends BaseProvider<Pozoriste> {
  PozoristeProvider() : super("Pozoriste");

  @override
  Pozoriste fromJson(data) {
    return Pozoriste.fromJson(data);
  }
}
