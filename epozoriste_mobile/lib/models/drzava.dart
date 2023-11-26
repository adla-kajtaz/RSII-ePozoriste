import 'package:json_annotation/json_annotation.dart';

part 'drzava.g.dart';

@JsonSerializable()
class Drzava {
  int drzavaId;
  String naziv;
  String skracenica;

  Drzava(
      {required this.drzavaId, required this.naziv, required this.skracenica});

  factory Drzava.fromJson(Map<String, dynamic> json) => _$DrzavaFromJson(json);
  Map<String, dynamic> toJson() => _$DrzavaToJson(this);
}
