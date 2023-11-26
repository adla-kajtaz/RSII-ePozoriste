import 'package:epozoriste_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pozoriste.g.dart';

@JsonSerializable()
class Pozoriste {
  int pozoristeId;
  String naziv;
  String adresa;
  String webstranica;
  String email;
  String brTelefona;
  String? logo;
  bool aktivan;
  int? gradId;
  Grad? grad;

  Pozoriste(
      {required this.pozoristeId,
      required this.naziv,
      required this.adresa,
      required this.webstranica,
      required this.email,
      required this.brTelefona,
      this.logo,
      required this.aktivan,
      this.gradId,
      this.grad});

  factory Pozoriste.fromJson(Map<String, dynamic> json) =>
      _$PozoristeFromJson(json);
  Map<String, dynamic> toJson() => _$PozoristeToJson(this);
}
