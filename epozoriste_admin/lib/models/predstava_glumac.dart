import 'package:epozoriste_admin/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'predstava_glumac.g.dart';

@JsonSerializable()
class PredstavaGlumac {
  int predstavaGlumacId;
  int glumacId;
  int predstavaId;
  String nazivUloge;
  Glumac? glumac;
  Predstava? predstava;
  PredstavaGlumac({
    required this.predstavaGlumacId,
    required this.glumacId,
    required this.predstavaId,
    required this.nazivUloge,
    this.glumac,
    this.predstava,
  });
  factory PredstavaGlumac.fromJson(Map<String, dynamic> json) =>
      _$PredstavaGlumacFromJson(json);
  Map<String, dynamic> toJson() => _$PredstavaGlumacToJson(this);
}
