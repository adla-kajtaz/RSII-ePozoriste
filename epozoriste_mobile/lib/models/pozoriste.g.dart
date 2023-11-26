// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pozoriste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pozoriste _$PozoristeFromJson(Map<String, dynamic> json) => Pozoriste(
      pozoristeId: json['pozoristeId'] as int,
      naziv: json['naziv'] as String,
      adresa: json['adresa'] as String,
      webstranica: json['webstranica'] as String,
      email: json['email'] as String,
      brTelefona: json['brTelefona'] as String,
      logo: json['logo'] as String?,
      aktivan: json['aktivan'] as bool,
      gradId: json['gradId'] as int?,
      grad: json['grad'] == null
          ? null
          : Grad.fromJson(json['grad'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PozoristeToJson(Pozoriste instance) => <String, dynamic>{
      'pozoristeId': instance.pozoristeId,
      'naziv': instance.naziv,
      'adresa': instance.adresa,
      'webstranica': instance.webstranica,
      'email': instance.email,
      'brTelefona': instance.brTelefona,
      'logo': instance.logo,
      'aktivan': instance.aktivan,
      'gradId': instance.gradId,
      'grad': instance.grad,
    };
