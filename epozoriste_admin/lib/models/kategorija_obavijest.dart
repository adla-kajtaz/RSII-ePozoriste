import 'package:json_annotation/json_annotation.dart';

part 'kategorija_obavijest.g.dart';

@JsonSerializable()
class KategorijaObavijest {
  int obavijestKategorijaId;
  String naziv;

  KategorijaObavijest({
    required this.obavijestKategorijaId,
    required this.naziv,
  });

  factory KategorijaObavijest.fromJson(Map<String, dynamic> json) =>
      _$KategorijaObavijestFromJson(json);
  Map<String, dynamic> toJson() => _$KategorijaObavijestToJson(this);
}
