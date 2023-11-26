import 'package:epozoriste_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kupovina.g.dart';

@JsonSerializable()
class Kupovina {
  int kupovinaId;
  int? kolicina;
  int? cijena;
  DateTime datumKupovine;
  String? paymentIntentId;
  int? korisnikId;
  Korisnik? korisnik;
  int? terminId;
  Termin? termin;
  bool? placena;

  Kupovina(
      {required this.kupovinaId,
      this.kolicina,
      this.cijena,
      required this.datumKupovine,
      this.paymentIntentId,
      this.korisnikId,
      this.korisnik,
      this.terminId,
      this.termin,
      this.placena});

  factory Kupovina.fromJson(Map<String, dynamic> json) =>
      _$KupovinaFromJson(json);
  Map<String, dynamic> toJson() => _$KupovinaToJson(this);
}
