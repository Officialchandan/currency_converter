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

  List<DataModel> countrycode = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Insert();
              },
              child: const Text("Click!!"),
            ),
            ElevatedButton(
              onPressed: () {
                showAll();
              },
              child: const Text("showall!!"),
            ),
            ElevatedButton(
              onPressed: () {
                particularrow();
              },
              child: const Text("particular row!!"),
            ),
          ],
        ),
      ),
    );
  }

  void particularrow() async {
    List<Map<String, dynamic>> row = await dbHelper.particular_row("INR");
    print("->>>>>>>>>>>>>>${row.first.values.toList()[3]}");
  }

  updateAll() async {
    DataModel currencyData = DataModel(
        value: "2",
        code: "USD",
        image: "",
        name: "american dollar",
        fav: 1,
        selected: 1);
    await dbHelper.update(currencyData.toMap());
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
        Map res = response.data!;
        Map<String, dynamic> quotes = res["quotes"];
        quotes.forEach((key, value) async {
          DataModel currencyData = DataModel(
              value: value.toString(),
              code: key,
              image: "",
              name: "",
              fav: 0,
              selected: 0);

          int id = await dbHelper.insert(currencyData.toMap());
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
      debugPrint("element-->$element");
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    });
    print(countrycode);
  }
}
