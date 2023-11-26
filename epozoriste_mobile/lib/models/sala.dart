import 'package:epozoriste_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sala.g.dart';

@JsonSerializable()
class Sala {
  int salaId;
  String naziv;
  int brSjedista;
  int brRedova;
  int brSjedistaPoRedu;
  int? pozoristeId;
  Pozoriste? pozoriste;

  Sala(
      {required this.salaId,
      required this.naziv,
      required this.brSjedista,
      required this.brRedova,
      required this.brSjedistaPoRedu,
      this.pozoristeId,
      this.pozoriste});

  factory Sala.fromJson(Map<String, dynamic> json) => _$SalaFromJson(json);
  Map<String, dynamic> toJson() => _$SalaToJson(this);
}
