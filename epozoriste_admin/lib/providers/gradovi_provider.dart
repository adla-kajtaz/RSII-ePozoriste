import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class GradoviProvider extends BaseProvider<Grad> {
  GradoviProvider() : super("Grad");

  @override
  Grad fromJson(data) {
    return Grad.fromJson(data);
  }
}
