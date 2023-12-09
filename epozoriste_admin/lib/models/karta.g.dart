// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Karta _$KartaFromJson(Map<String, dynamic> json) => Karta(
      kartaId: json['kartaId'] as int,
      aktivna: json['aktivna'] as bool,
      brojSjedista: json['brojSjedista'] as int,
      brojReda: json['brojReda'] as String,
      sjediste: json['sjediste'] as String,
      terminId: json['terminId'] as int?,
      termin: json['termin'] == null
          ? null
          : Termin.fromJson(json['termin'] as Map<String, dynamic>),
      kupovinaId: json['kupovinaId'] as int?,
      kupovina: json['kupovina'] == null
          ? null
          : Kupovina.fromJson(json['kupovina'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KartaToJson(Karta instance) => <String, dynamic>{
      'kartaId': instance.kartaId,
      'aktivna': instance.aktivna,
      'brojSjedista': instance.brojSjedista,
      'brojReda': instance.brojReda,
      'sjediste': instance.sjediste,
      'terminId': instance.terminId,
      'termin': instance.termin,
      'kupovinaId': instance.kupovinaId,
      'kupovina': instance.kupovina,
    };
