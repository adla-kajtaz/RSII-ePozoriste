import 'package:epozoriste_admin/models/kategorija_obavijest.dart';
import 'package:epozoriste_admin/providers/base_provider.dart';
import '../models/models.dart';

class KategorijaObavijestProvider extends BaseProvider<KategorijaObavijest> {
  KategorijaObavijestProvider() : super("ObavijestKategorija");

  @override
  KategorijaObavijest fromJson(data) {
    return KategorijaObavijest.fromJson(data);
  }
}
