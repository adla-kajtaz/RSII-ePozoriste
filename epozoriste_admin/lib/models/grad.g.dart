// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grad _$GradFromJson(Map<String, dynamic> json) => Grad(
      gradId: json['gradId'] as int,
      naziv: json['naziv'] as String,
      postanskiBr: json['postanskiBr'] as String,
      drzavaId: json['drzavaId'] as int?,
      drzava: json['drzava'] == null
          ? null
          : Drzava.fromJson(json['drzava'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GradToJson(Grad instance) => <String, dynamic>{
      'gradId': instance.gradId,
      'naziv': instance.naziv,
      'postanskiBr': instance.postanskiBr,
      'drzavaId': instance.drzavaId,
      'drzava': instance.drzava,
    };
