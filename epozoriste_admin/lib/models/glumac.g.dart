// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glumac.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Glumac _$GlumacFromJson(Map<String, dynamic> json) => Glumac(
      glumacId: json['glumacId'] as int,
      ime: json['ime'] as String,
      prezime: json['prezime'] as String,
      slika: json['slika'] as String?,
      imePrezime: json['imePrezime'] as String,
    );

Map<String, dynamic> _$GlumacToJson(Glumac instance) => <String, dynamic>{
      'glumacId': instance.glumacId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'slika': instance.slika,
      'imePrezime': instance.imePrezime,
    };
