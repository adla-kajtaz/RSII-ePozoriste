import 'package:epozoriste_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'obavijest.g.dart';

@JsonSerializable()
class Obavijest {
  int obavijestId;
  String naslov;
  String podnaslov;
  String sadrzaj;
  String? slika;
  DateTime datumKreiranja;
  int? obavijestKategorijaId;
  ObavijestKategorija? obavijestKategorija;
  int? korisnikId;
  Korisnik korisnik;

  Obavijest(
      {required this.obavijestId,
      required this.naslov,
      required this.podnaslov,
      required this.sadrzaj,
      this.slika,
      required this.datumKreiranja,
      this.obavijestKategorijaId,
      this.obavijestKategorija,
      this.korisnikId,
      required this.korisnik});

  factory Obavijest.fromJson(Map<String, dynamic> json) =>
      _$ObavijestFromJson(json);
  Map<String, dynamic> toJson() => _$ObavijestToJson(this);
}
