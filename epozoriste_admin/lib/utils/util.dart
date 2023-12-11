import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Authorization {
  static String? username;
  static String? password;
  static int? korisnikId;
}

Image imageFromBase64String(String base64String, int? width, int? height) {
  return Image.memory(
    base64Decode(base64String),
    fit: BoxFit.cover,
    width: width?.toDouble(),
    height: height?.toDouble(),
  );
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');
  if (dynamic == null) {
    return "";
  }

  return f.format(dynamic);
}

String formatDateTime(DateTime dateTime) {
  final daysOfWeek = [
    'Ponedeljak',
    'Utorak',
    'Srijeda',
    'Četvrtak',
    'Petak',
    'Subota',
    'Nedelja'
  ];
  final monthsOfYear = [
    'Januar',
    'Februar',
    'Mart',
    'April',
    'Maj',
    'Juni',
    'Juli',
    'August',
    'Septembar',
    'Oktobar',
    'Novembar',
    'Decembar'
  ];

  final dayOfWeek = daysOfWeek[dateTime.weekday - 1];
  final day = dateTime.day;
  final month = monthsOfYear[dateTime.month - 1];
  final year = dateTime.year;

  return '$dayOfWeek, $day. $month $year.';
}
