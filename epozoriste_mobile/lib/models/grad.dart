import 'package:epozoriste_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grad.g.dart';

@JsonSerializable()
class Grad {
  int gradId;
  String naziv;
  String postanskiBr;
  int? drzavaId;
  Drzava? drzava;

  Grad(
      {required this.gradId,
      required this.naziv,
      required this.postanskiBr,
      this.drzavaId,
      this.drzava});

  factory Grad.fromJson(Map<String, dynamic> json) => _$GradFromJson(json);
  Map<String, dynamic> toJson() => _$GradToJson(this);
}
