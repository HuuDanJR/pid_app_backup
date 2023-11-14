// To parse this JSON data, do
//
//     final pidModel = pidModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PidModel pidModelFromJson(String str) => PidModel.fromJson(json.decode(str));

String pidModelToJson(PidModel data) => json.encode(data.toJson());

class PidModel {
    final String rl1;
    final String rl2;
    final String bc3;
    final String bc4;

    PidModel({
        required this.rl1,
        required this.rl2,
        required this.bc3,
        required this.bc4,
    });

    factory PidModel.fromJson(Map<String, dynamic> json) => PidModel(
        rl1: json["rl1"],
        rl2: json["rl2"],
        bc3: json["bc3"],
        bc4: json["bc4"],
    );

    Map<String, dynamic> toJson() => {
        "rl1": rl1,
        "rl2": rl2,
        "bc3": bc3,
        "bc4": bc4,
    };
}
