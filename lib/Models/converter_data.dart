// To parse this JSON data, do
//
//     final converterData = converterDataFromMap(jsonString);

import 'dart:convert';

class ConverterData {
  ConverterData({this.from, this.to});
  Map<String, double>? from;
  Map<String, double>? to;
  factory ConverterData.fromJson(String str) =>
      ConverterData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConverterData.fromMap(Map<String, dynamic> json) => ConverterData(
        from: json["from"] == null
            ? {}
            : Map.from(json["from"]).map((k, v) =>
                MapEntry<String, double>(k, double.parse(v.toString()))),
        to: json["to"] == null
            ? null
            : Map.from(json["to"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "from": from == null
            ? null
            : Map.from(from!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "to": to == null
            ? null
            : Map.from(to!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
