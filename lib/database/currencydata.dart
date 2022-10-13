import 'package:flutter/material.dart';

class DataModel {
  String? name;
  String? image;
  String code;
  String value;
  int? selected;
  int? fav;
  int? timeStamp;
  bool iconForSelection = false;
  TextEditingController controller = TextEditingController(text: "00.0");
  String exchangeValue = "0";
  String? symbol;
  final Key? key;
  int? itemIndex;
  DataModel(
      {required this.value,
      required this.code,
      this.image,
      this.name,
      this.fav = 0,
      this.timeStamp = 0,
      this.selected = 0,
      this.iconForSelection = false,
      this.symbol = "",
      this.key = const ValueKey("0"),
      this.itemIndex = 0});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        name: json["countryName"] ?? "",
        image: json["countryImage"] ?? "",
        code: json["countryCode"] ?? "",
        value: json["currencyValue"] ?? "",
        selected: json["selectedCountry"] ?? 0,
        fav: json["favCountry"] ?? 0,
        timeStamp: json["timeStamp"] ?? 0,
        symbol: json["symbol"] ?? "",
        itemIndex: json["indexOfItem"] ?? 0,
      );
  Map<String, dynamic> toMap() => {
        "countryName": name ?? "",
        "countryImage": image ?? "",
        "countryCode": code,
        "currencyValue": value,
        "selectedCountry": selected ?? 0,
        "favCountry": fav ?? 0,
        "timeStamp": timeStamp ?? 0,
        "symbol": symbol ?? "",
        "indexOfItem": itemIndex ?? 0,
      };

  @override
  String toString() {
    return 'DataModel{name: $name, image: $image, code: $code, value: $value, selected: $selected, fav: $fav, timeStamp: $timeStamp, iconForSelection: $iconForSelection, exchangeValue: $exchangeValue, symbol: $symbol,indexOfItem: $itemIndex}';
  }
}
