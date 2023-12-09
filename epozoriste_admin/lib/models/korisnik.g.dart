// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      korisnikId: json['korisnikId'] as int?,
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      korisnickoIme: json['korisnickoIme'] as String?,
      email: json['email'] as String?,
      brTelefona: json['brTelefona'] as String?,
      lozinka: json['lozinka'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'brTelefona': instance.brTelefona,
      'lozinka': instance.lozinka,
    };
