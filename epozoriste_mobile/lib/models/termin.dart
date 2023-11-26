import 'package:epozoriste_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'termin.g.dart';

@JsonSerializable()
class Termin {
  int terminId;
  bool premijera;
  bool predpremijera;
  int cijenaKarte;
  DateTime datumOdrzavanja;
  String vrijemeOdrzavanja;
  int? salaId;
  Sala? sala;
  int? predstavaId;
  Predstava? predstava;

  Termin(
      {required this.terminId,
      required this.premijera,
      required this.predpremijera,
      required this.cijenaKarte,
      required this.datumOdrzavanja,
      required this.vrijemeOdrzavanja,
      this.salaId,
      this.sala,
      this.predstavaId,
      this.predstava});

  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);
  Map<String, dynamic> toJson() => _$TerminToJson(this);
}
