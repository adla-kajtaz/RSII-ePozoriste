import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class VrstaPredstaveProvider extends BaseProvider<VrstaPredstave> {
  VrstaPredstaveProvider() : super("VrstaPredstave");

  @override
  VrstaPredstave fromJson(data) {
    return VrstaPredstave.fromJson(data);
  }
}
