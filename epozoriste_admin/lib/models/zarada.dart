import 'package:json_annotation/json_annotation.dart';

part 'zarada.g.dart';

@JsonSerializable()
class Zarada {
  int brKarata;
  int brTermina;
  int ukupnaZarada;

  Zarada({
    required this.brKarata,
    required this.brTermina,
    required this.ukupnaZarada,
  });

  factory Zarada.fromJson(Map<String, dynamic> json) => _$ZaradaFromJson(json);
  Map<String, dynamic> toJson() => _$ZaradaToJson(this);
}
