import 'package:json_annotation/json_annotation.dart';

part 'vrstaPredstave.g.dart';

@JsonSerializable()
class VrstaPredstave {
  int vrstaPredstaveId;
  String naziv;

  VrstaPredstave({required this.vrstaPredstaveId, required this.naziv});

  factory VrstaPredstave.fromJson(Map<String, dynamic> json) =>
      _$VrstaPredstaveFromJson(json);
  Map<String, dynamic> toJson() => _$VrstaPredstaveToJson(this);
}
