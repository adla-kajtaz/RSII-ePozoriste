import 'package:epozoriste_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

import 'kupovina.dart';

part 'karta.g.dart';

@JsonSerializable()
class Karta {
  int kartaId;
  bool aktivna;
  int brojSjedista;
  String brojReda;
  String sjediste;
  int? terminId;
  Termin? termin;
  int? kupovinaId;
  Kupovina? kupovina;

  Karta({
    required this.kartaId,
    required this.aktivna,
    required this.brojSjedista,
    required this.brojReda,
    required this.sjediste,
    this.terminId,
    this.termin,
    this.kupovinaId,
    required this.kupovina,
  });

  factory Karta.fromJson(Map<String, dynamic> json) => _$KartaFromJson(json);
  Map<String, dynamic> toJson() => _$KartaToJson(this);
}
