import 'package:json_annotation/json_annotation.dart';

part 'obavijestKategorija.g.dart';

@JsonSerializable()
class ObavijestKategorija {
  int obavijestKategorijaId;
  String naziv;

  ObavijestKategorija(
      {required this.obavijestKategorijaId, required this.naziv});

  factory ObavijestKategorija.fromJson(Map<String, dynamic> json) =>
      _$ObavijestKategorijaFromJson(json);
  Map<String, dynamic> toJson() => _$ObavijestKategorijaToJson(this);
}
