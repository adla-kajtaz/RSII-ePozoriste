// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
      terminId: json['terminId'] as int,
      premijera: json['premijera'] as bool,
      predpremijera: json['predpremijera'] as bool,
      cijenaKarte: json['cijenaKarte'] as int,
      datumOdrzavanja: DateTime.parse(json['datumOdrzavanja'] as String),
      vrijemeOdrzavanja: json['vrijemeOdrzavanja'] as String,
      salaId: json['salaId'] as int?,
      sala: json['sala'] == null
          ? null
          : Sala.fromJson(json['sala'] as Map<String, dynamic>),
      predstavaId: json['predstavaId'] as int?,
      predstava: json['predstava'] == null
          ? null
          : Predstava.fromJson(json['predstava'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminId': instance.terminId,
      'premijera': instance.premijera,
      'predpremijera': instance.predpremijera,
      'cijenaKarte': instance.cijenaKarte,
      'datumOdrzavanja': instance.datumOdrzavanja.toIso8601String(),
      'vrijemeOdrzavanja': instance.vrijemeOdrzavanja,
      'salaId': instance.salaId,
      'sala': instance.sala,
      'predstavaId': instance.predstavaId,
      'predstava': instance.predstava,
    };
