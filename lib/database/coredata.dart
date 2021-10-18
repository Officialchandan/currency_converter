import 'dart:async';
import 'dart:developer';
import 'package:currency_converter/database/currencydata.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = 'currencyconverter1.db';
  static final _dbVersion = 1;
  static final tableName = "conversion";
  static final ColumnId = "id";
  static final countryCode = "countryCode";
  static final countryImage = "countryImage";
  static final currencyValue = "currencyValue";
  static final favCountry = "favCountry";
  static final selectedCountry = "selectedCountry";
  static final countryName = "countryName";

  DatabaseHelper._p();

  //static DatabaseHelper instance = DatabaseHelper._p();

  static final DatabaseHelper instance = DatabaseHelper._p();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initdb();
    return _database!;
  }

  initdb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableName (
            $ColumnId INTEGER PRIMARY KEY,
            $countryCode TEXT NOT NULL,
            $countryImage TEXT NOT NULL,
            $currencyValue TEXT NOT NULL,
            $favCountry INTEGER NOT NULL,
            $countryName TEXT NOT NULL,
            $selectedCountry INTEGER NOT NULL
            )''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    //print("data->$row");
    Database db = await instance.database;

    Map<String, dynamic> existData = await isExist(row["countryCode"]);
    if (existData.isNotEmpty) {
      DataModel data = DataModel.fromMap(existData);
      data.value = row["currencyValue"].toString();
      return update(data.toMap());
    } else {
      return await db.insert(tableName, row);
    }
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(tableName);

    //print("data--->$data");

    return data;
  }

  Future<Map<String, dynamic>> isExist(String code) async {
    Map<String, dynamic> currencyData = {};

    Database db = await instance.database;

    // String query= "SELECT * FROM $"
    List<Map<String, dynamic>> data = await db
        .query(tableName, where: '$countryCode =  ?', whereArgs: [code]);

    // log("isExist - data -->$data");

    if (data.isNotEmpty) {
      currencyData = data[0];
    }
    return currencyData;
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String code = row["countryCode"];
    return await db
        .update(tableName, row, where: '$countryCode =  ?', whereArgs: [code]);
  }

  Future<List<Map<String, dynamic>>> order() async {
    Database db = await instance.database;

    List<Map<String, dynamic>> data = await db.rawQuery(
        "SELECT * FROM " + tableName + " ORDER BY " + favCountry + " DESC",
        null);
    print("bnbbfsdbfsdbjsdbsdk->>>$data");
    return data;
  }

  Future<List<Map<String, dynamic>>> particular_row(String conCode) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db
        .query(tableName, where: '$countryCode =  ?', whereArgs: [conCode]);

    print("data--->${data.first.values.toList()[3]}");

    return data;
  }

  Future<List<DataModel>> getSelectedData() async {
    List<DataModel> dataList = [];

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> data = await db
          .query(tableName, where: "$selectedCountry = ?", whereArgs: [1]);

      log("getSelectedData-->$data");

      if (data.isNotEmpty) {
        for (var element in data) {
          DataModel model = DataModel.fromMap(element);
          model.iconForSelection = true;
          dataList.add(model);
        }
      }
    } catch (exception) {
      debugPrint("exception in getSelectedData --> $exception");
    }

    return dataList;
  }

  Future<List<DataModel>> getUnselectedData() async {
    List<DataModel> dataList = [];

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> data = await db
          .query(tableName, where: "$selectedCountry = ?", whereArgs: [0]);

      if (data.isNotEmpty) {
        for (var element in data) {
          DataModel model = DataModel.fromMap(element);
          dataList.add(model);
        }
      }
    } catch (exception) {
      debugPrint("exception in getSelectedData --> $exception");
    }

    return dataList;
  }
}
