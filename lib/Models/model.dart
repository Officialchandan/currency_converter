  // To parse this JSON data, do
//
//     final dataClass = dataClassFromMap(jsonString);

import 'dart:convert';

class DataClass {
  DataClass({
    this.timestamp,
    this.quotes,
    this.quotesYesterday,
    this.quotesNinty,
  });

  int? timestamp;
  Map<String, double>? quotes;
  Map<String, double>? quotesYesterday;
  Map<String, double>? quotesNinty;

  factory DataClass.fromJson(String str) => DataClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataClass.fromMap(Map<String, dynamic> json) => DataClass(
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        quotes: json["quotes"] == null
            ? null
            : Map.from(json["quotes"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        quotesYesterday: json["quotes_yesterday"] == null
            ? null
            : Map.from(json["quotes_yesterday"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        quotesNinty: json["quotes_ninty"] == null
            ? null
            : Map.from(json["quotes_ninty"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "timestamp": timestamp == null ? null : timestamp,
        "quotes": quotes == null
            ? null
            : Map.from(quotes!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "quotes_yesterday": quotesYesterday == null
            ? null
            : Map.from(quotesYesterday!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "quotes_ninty": quotesNinty == null
            ? null
            : Map.from(quotesNinty!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
