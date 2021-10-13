import 'dart:convert';

class DataModel{
  String? name;
  String? image;
  String code;
  String value;
  int? selected;
  int? fav;
  DataModel({required this.value,required this.code,this.image,this.name,this.fav=0,this.selected=0});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
      name: json["countryName"]??"",
    image: json["countryImage"]??"",
    code: json["countryCode"]??"",
    value: json["currencyValue"]??"",
    selected: json["selectedCountry"]??0,
    fav: json["favCountry"]??0,



  );
  Map<String, dynamic> toMap() => {
    "countryName": name ?? "",
    "countryImage": image ?? "",
    "countryCode": code,
    "currencyValue": value ,
    "selectedCountry": selected ??0,
    "favCountry": fav ?? 0,

  };

}