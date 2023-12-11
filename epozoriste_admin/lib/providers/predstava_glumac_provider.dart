import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class PredstavaGlumacProvider extends BaseProvider<PredstavaGlumac> {
  PredstavaGlumacProvider() : super("PredstavaGlumac");

  @override
  PredstavaGlumac fromJson(data) {
    return PredstavaGlumac.fromJson(data);
  }
}
