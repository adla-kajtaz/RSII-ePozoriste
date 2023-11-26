// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sala _$SalaFromJson(Map<String, dynamic> json) => Sala(
      salaId: json['salaId'] as int,
      naziv: json['naziv'] as String,
      brSjedista: json['brSjedista'] as int,
      brRedova: json['brRedova'] as int,
      brSjedistaPoRedu: json['brSjedistaPoRedu'] as int,
      pozoristeId: json['pozoristeId'] as int?,
      pozoriste: json['pozoriste'] == null
          ? null
          : Pozoriste.fromJson(json['pozoriste'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SalaToJson(Sala instance) => <String, dynamic>{
      'salaId': instance.salaId,
      'naziv': instance.naziv,
      'brSjedista': instance.brSjedista,
      'brRedova': instance.brRedova,
      'brSjedistaPoRedu': instance.brSjedistaPoRedu,
      'pozoristeId': instance.pozoristeId,
      'pozoriste': instance.pozoriste,
    };
