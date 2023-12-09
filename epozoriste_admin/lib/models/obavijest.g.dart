// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavijest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obavijest _$ObavijestFromJson(Map<String, dynamic> json) => Obavijest(
      obavijestId: json['obavijestId'] as int,
      naslov: json['naslov'] as String,
      podnaslov: json['podnaslov'] as String,
      sadrzaj: json['sadrzaj'] as String,
      slika: json['slika'] as String?,
      datumKreiranja: DateTime.parse(json['datumKreiranja'] as String),
      obavijestKategorijaId: json['obavijestKategorijaId'] as int?,
      obavijestKategorija: json['obavijestKategorija'] == null
          ? null
          : ObavijestKategorija.fromJson(
              json['obavijestKategorija'] as Map<String, dynamic>),
      korisnikId: json['korisnikId'] as int?,
      korisnik: Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ObavijestToJson(Obavijest instance) => <String, dynamic>{
      'obavijestId': instance.obavijestId,
      'naslov': instance.naslov,
      'podnaslov': instance.podnaslov,
      'sadrzaj': instance.sadrzaj,
      'slika': instance.slika,
      'datumKreiranja': instance.datumKreiranja.toIso8601String(),
      'obavijestKategorijaId': instance.obavijestKategorijaId,
      'obavijestKategorija': instance.obavijestKategorija,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
    };
