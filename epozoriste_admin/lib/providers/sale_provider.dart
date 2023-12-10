import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class SaleProvider extends BaseProvider<Sala> {
  SaleProvider() : super("Sala");

  @override
  Sala fromJson(data) {
    return Sala.fromJson(data);
  }
}
