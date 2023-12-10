import 'package:json_annotation/json_annotation.dart';

part 'glumac.g.dart';

@JsonSerializable()
class Glumac {
  int glumacId;
  String ime;
  String prezime;
  String? slika;
  String imePrezime;

  Glumac(
      {required this.glumacId,
      required this.ime,
      required this.prezime,
      this.slika,
      required this.imePrezime});

  factory Glumac.fromJson(Map<String, dynamic> json) => _$GlumacFromJson(json);
  Map<String, dynamic> toJson() => _$GlumacToJson(this);
}
