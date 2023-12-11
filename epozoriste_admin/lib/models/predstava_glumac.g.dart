// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predstava_glumac.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredstavaGlumac _$PredstavaGlumacFromJson(Map<String, dynamic> json) =>
    PredstavaGlumac(
      predstavaGlumacId: json['predstavaGlumacId'] as int,
      glumacId: json['glumacId'] as int,
      predstavaId: json['predstavaId'] as int,
      nazivUloge: json['nazivUloge'] as String,
      glumac: json['glumac'] == null
          ? null
          : Glumac.fromJson(json['glumac'] as Map<String, dynamic>),
      predstava: json['predstava'] == null
          ? null
          : Predstava.fromJson(json['predstava'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PredstavaGlumacToJson(PredstavaGlumac instance) =>
    <String, dynamic>{
      'predstavaGlumacId': instance.predstavaGlumacId,
      'glumacId': instance.glumacId,
      'predstavaId': instance.predstavaId,
      'nazivUloge': instance.nazivUloge,
      'glumac': instance.glumac,
      'predstava': instance.predstava,
    };
