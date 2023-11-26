// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predstava.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Predstava _$PredstavaFromJson(Map<String, dynamic> json) => Predstava(
      predstavaId: json['predstavaId'] as int,
      naziv: json['naziv'] as String,
      sadrzaj: json['sadrzaj'] as String,
      slika: json['slika'] as String?,
      vrijemeTrajanje: json['vrijemeTrajanje'] as int,
      rezija: json['rezija'] as String,
      scenografija: json['scenografija'] as String,
      kostimografija: json['kostimografija'] as String,
      vrstaPredstaveId: json['vrstaPredstaveId'] as int?,
      vrstaPredstave: json['vrstaPredstave'] == null
          ? null
          : VrstaPredstave.fromJson(
              json['vrstaPredstave'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PredstavaToJson(Predstava instance) => <String, dynamic>{
      'predstavaId': instance.predstavaId,
      'naziv': instance.naziv,
      'sadrzaj': instance.sadrzaj,
      'slika': instance.slika,
      'vrijemeTrajanje': instance.vrijemeTrajanje,
      'rezija': instance.rezija,
      'scenografija': instance.scenografija,
      'kostimografija': instance.kostimografija,
      'vrstaPredstaveId': instance.vrstaPredstaveId,
      'vrstaPredstave': instance.vrstaPredstave,
    };
