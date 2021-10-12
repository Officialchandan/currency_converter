import 'dart:convert';

import 'package:currency_converter/Models/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coredata.dart';
import 'currencydata.dart';

class Intrigation extends StatefulWidget {
  const Intrigation({Key? key}) : super(key: key);

  @override
  _IntrigationState createState() => _IntrigationState();
}

class _IntrigationState extends State<Intrigation> {

  final dbHelper = DatabaseHelper.instance;
  
List<CurrencyData> countrycode=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          children: [
            Container(
              child: ElevatedButton(
                onPressed: (){
                  Insert();
                },
                child: Text("Click!!"),

              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: (){
                  showAll();
                },
                child: Text("showall!!"),

              ),
            ),
          ],
        ),
      ),

    );
  }

  Future<void> Insert() async {
    print("Bobel");

    String url =
        "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";

    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        //ConverterData converterData = ConverterData.fromJson(response.toString());
        Map res=response.data!;
        Map<String,dynamic> quotes=res["quotes"];
        quotes.forEach((key, value) async {

          CurrencyData currencyData=CurrencyData(value: value,code: key,image: "",name: "",fav: false,selected: false);

       int id= await dbHelper.insert(currencyData.toMap());
       print("id->>>>>$id");

        });


      } else {
        print("NOT FOUND DATA");
      }
    } catch (e) {
      print(e);
    }


  }

  void showAll() async {

    List<Map<String, dynamic>> allRows = await dbHelper.queryAll();
    allRows.forEach((element) {
      // CurrencyData currencyData=CurrencyData.fromJson(jsonEncode(element));
      // countrycode.add(currencyData);
    });
    print(countrycode);


  }
}
