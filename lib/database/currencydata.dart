import 'dart:convert';

class CurrencyData{
  String? name;
  String? image;
  String code;
  dynamic value;

  bool? selected;
  bool? fav;
  CurrencyData({required this.value,required this.code,this.image,this.name,this.fav=false,this.selected=false});

  factory CurrencyData.fromMap(Map<String, dynamic> json) => CurrencyData(
      name: json["countryName"]??"",
    image: json["countryImage"]??"",
    code: json["countryCode"]??"",
    value: json["currencyValue"]??0.00,
    selected: json["selectedCountry"]??false,
    fav: json["favCountry"]??false,



  );
  Map<String, dynamic> toMap() => {
    "countryName": name ?? null,
    "countryImage": image ?? null,
    "countryCode": code ?? "",
    "currencyValue": value ?? 0.00,
    "selectedCountry": selected ?? null,
    "favCountry": fav ?? null,

  };

}