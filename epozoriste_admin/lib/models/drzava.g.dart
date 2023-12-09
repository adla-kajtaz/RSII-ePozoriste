// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drzava.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drzava _$DrzavaFromJson(Map<String, dynamic> json) => Drzava(
      drzavaId: json['drzavaId'] as int,
      naziv: json['naziv'] as String,
      skracenica: json['skracenica'] as String,
    );

Map<String, dynamic> _$DrzavaToJson(Drzava instance) => <String, dynamic>{
      'drzavaId': instance.drzavaId,
      'naziv': instance.naziv,
      'skracenica': instance.skracenica,
    };
