import 'dart:convert';

PidModel pidModelFromJson(String str) => PidModel.fromJson(json.decode(str));


class PidModel {
  final String rl1;
  final String rl2;
  final String bc3;
  final String bc4;
  final String bc5;
  final String bc6;
  final String ads;

  PidModel({
    required this.rl1,
    required this.rl2,
    required this.bc3,
    required this.bc4,
    required this.bc5,
    required this.bc6,
    required this.ads,
  });

  factory PidModel.fromJson(Map<String, dynamic> json) => PidModel(
        rl1: json["rl1"] ?? '',
        rl2: json["rl2"] ?? '',
        bc3: json["bc3"] ?? '',
        bc4: json["bc4"] ?? '',
        bc5: json["bc5"] ?? '',
        bc6: json["bc6"] ?? '',
        ads: json['ads'] ?? ''
      );

 
}
