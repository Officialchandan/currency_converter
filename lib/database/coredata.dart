import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:currency_converter/database/color_data.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = 'currencyconverter4.db'; //database Name
  static const _dbVersion = 1; // database Version
  static const tableName = "conversion"; // table Name
  static const ColumnId = "id"; //Id
  static const countryCode = "countryCode";
  static const countryImage = "countryImage";
  static const currencyValue = "currencyValue";
  static const favCountry = "favCountry";
  static const timeStamp = "timeStamp";
  static const selectedCountry = "selectedCountry";
  static const countryName = "countryName";
  static const symbol = "symbol";
  static const itemIndex = "indexOfItem";

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

    debugPrint("database path-->$path");

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableName (
            $ColumnId INTEGER PRIMARY KEY,
            $countryCode TEXT NOT NULL UNIQUE,
            $countryImage TEXT NOT NULL,
            $currencyValue TEXT NOT NULL,
            $favCountry INTEGER NOT NULL,
            $timeStamp INTEGER NOT NULL,
            $countryName TEXT NOT NULL,
            $selectedCountry INTEGER NOT NULL,
            $symbol TEXT NOT NULL,
            $itemIndex INTEGER NOT NULL
            )''');
    await db.execute('''CREATE TABLE ${ColorsConst.colorTable} (
            ${ColorsConst.colorId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${ColorsConst.colorCode} TEXT NOT NULL,
            ${ColorsConst.selected} INTEGER NOT NULL,
            ${ColorsConst.isLocked} INTEGER NOT NULL,
            ${ColorsConst.previousColor} INTEGER NOT NULL
            )''');

    // await db.execute('''CREATE TABLE ${ColorsConst.lockColorTable} (
    //         ${ColorsConst.colorId} INTEGER PRIMARY KEY AUTOINCREMENT,
    //         ${ColorsConst.colorCode} TEXT NOT NULL,
    //         ${ColorsConst.selected} TEXT NOT NULL ,
    //         ${ColorsConst.previousColor} TEXT NOT NULL
    //         )''');

    // await db.execute('''CREATE TABLE ${ColorsConst.unLockColorTable} (
    //    ${ColorsConst.colorId} INTEGER PRIMARY KEY AUTOINCREMENT,
    //         ${ColorsConst.colorCode} TEXT NOT NULL,
    //         ${ColorsConst.selected} TEXT NOT NULL ,
    //         ${ColorsConst.previousColor} TEXT NOT NULL
    //         )''');

    await db.execute('''CREATE TABLE ${ColorsConst.densityColorTable} (
       ${ColorsConst.colorId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${ColorsConst.colorCode} TEXT NOT NULL,
            ${ColorsConst.selected} TEXT NOT NULL ,
            ${ColorsConst.parentColorCode} TEXT NOT NULL,
            ${ColorsConst.previousColor} TEXT NOT NULL
            )''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    //debugPrint("data->$row");
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

    debugPrint("data  --->$data");

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

    List<Map<String, dynamic>> data = await db.rawQuery("SELECT * FROM " +
        tableName +
        " ORDER BY " +
        favCountry +
        " DESC, $countryCode ASC ");
    debugPrint("->>>$data");
    return data;
  }

  Future<List<Map<String, dynamic>>> particular_row(String conCode) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db
        .query(tableName, where: '$countryCode =  ?', whereArgs: [conCode]);

    // debugPrint("data--->${data.first.values.toList()}");

    return data;
  }

  Future<List<DataModel>> getSelectedData() async {
    List<DataModel> dataList = [];

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> data = await db.query(
        tableName,
        where: "$selectedCountry = ?",
        whereArgs: [1],
        orderBy: "$timeStamp ASC",
      );

      log("getSelectedData-->$data");

      if (data.isNotEmpty) {
        for (var element in data) {
          DataModel model = DataModel.fromMap(element);
          model.iconForSelection = true;

          DataModel dataModel = DataModel(
              value: model.value,
              code: model.code,
              fav: model.fav,
              iconForSelection: model.iconForSelection,
              image: model.image,
              name: model.name,
              selected: model.selected,
              symbol: model.symbol,
              timeStamp: model.timeStamp,
              key: ValueKey(model.code),
              itemIndex: model.itemIndex);

          dataList.add(dataModel);
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
      List<Map<String, dynamic>> data = await db.query(tableName,
          where: "$selectedCountry = ?",
          whereArgs: [0],
          orderBy: "$countryCode ASC",
          groupBy: countryCode);

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

  Future<int> insertColor(ColorTable color) async {
    debugPrint("insertColor--->");
    int i = 0;

    try {
      Database db = await instance.database;

      bool isExist = await checkColorCodeExist(color);
      if (isExist) {
        selectColor(color);
      } else {
        i = await db.insert(ColorsConst.colorTable, color.toMap());
      }
      debugPrint("i--->$i");
    } catch (excption) {
      debugPrint("excption--->$excption");
    }

    return i;
  }

  Future<int> removeColor(ColorTable color) async {
    debugPrint("removeColor--->");
    int i = 0;
    try {
      Database db = await instance.database;
      i = await db
          .delete(ColorsConst.colorTable, where: '$color', whereArgs: [color]);
    } catch (e) {
      debugPrint("excption--->$e");
    }
    return i;
  }

  Future<bool> checkColorCodeExist(ColorTable color) async {
    debugPrint("checkColorCodeExist--->");
    bool exist = false;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.query(ColorsConst.colorTable,
          where: "${ColorsConst.colorCode}=?", whereArgs: [color.colorCode]);

      debugPrint("result-->$result");

      exist = result.isNotEmpty;
    } catch (exception) {
      debugPrint("exception--->$exception");
    }

    return exist;
  }

  Future<int> selectColor(ColorTable color) async {
    debugPrint("selectColor--->");

    int i = 0;

    try {
      Database db = await instance.database;
      i = await db.update(ColorsConst.colorTable, color.toMap(),
          where: "${ColorsConst.colorCode} = ?", whereArgs: [color.colorCode]);
      debugPrint("i-->$i");
    } catch (exception) {
      debugPrint("exception--->$exception");
    }

    return i;
  }

  Future<int> deSelectColor() async {
    debugPrint("deSelectColor--->");

    int i = 0;

    try {
      Database db = await instance.database;
      i = await db.rawUpdate(
          "UPDATE ${ColorsConst.colorTable} SET ${ColorsConst.selected} = 0 WHERE ${ColorsConst.selected} = ?",
          [1]);
      debugPrint("i-->$i");
      db.getVersion();
    } catch (exception) {
      debugPrint("exception--->$exception");
    }

    return i;
  }

  Future<int> insertDensityColor(DensityColor color) async {
    debugPrint("insertDensityColor--->");
    int i = 0;

    try {
      Database db = await instance.database;

      i = await db.insert(ColorsConst.densityColorTable, color.toMap());
      debugPrint("i--->$i");
    } catch (excption) {
      debugPrint("excption--->$excption");
    }

    return i;
  }

  Future<bool> isColorsExist() async {
    debugPrint("isColorExist--->");
    bool exist = false;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result =
          await db.rawQuery("SELECT * FROM ${ColorsConst.colorTable}");

      debugPrint("result-->$result");

      exist = result.isEmpty;
    } catch (exception) {
      debugPrint("exception--->$exception");
    }

    return exist;
  }

  Future<List<ColorTable>> getSelectedColor() async {
    debugPrint("getselectedColor--->");

    List<ColorTable> selsctedColors = [];

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.rawQuery(
          "SELECT * FROM ${ColorsConst.colorTable} WHERE ${ColorsConst.selected} = ?",
          [1]);
      debugPrint("result-->$result");
      for (var element in result) {
        ColorTable unlockColor = ColorTable.fromMap(element);
        selsctedColors.add(unlockColor);
      }

      debugPrint("selsctedColors-->$selsctedColors");
    } catch (exception) {
      debugPrint("exception--->$exception");
    }

    return selsctedColors;
  }

  Future<List<ColorTable>> getColors() async {
    debugPrint("getColors-->");

    List<ColorTable> colors = [];
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result =
          await db.rawQuery("SELECT * FROM ${ColorsConst.colorTable}");
      debugPrint("result-->$result");
      for (var element in result) {
        ColorTable color = ColorTable.fromMap(element);
        colors.add(color);
      }
    } catch (exception) {
      debugPrint(exception.toString());
    }

    return colors;
  }

  Future<List<DensityColor>> getDensityColors(String colorCode) async {
    debugPrint("getDensityColors-->");

    List<DensityColor> colors = [];
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.rawQuery(
          "SELECT * FROM ${ColorsConst.densityColorTable} WHERE ${ColorsConst.parentColorCode} = ?",
          [colorCode]);
      debugPrint("result-->$result");
      for (var element in result) {
        DensityColor color = DensityColor.fromMap(element);
        colors.add(color);
      }
    } catch (exception) {
      debugPrint("exception--->$exception");
    }

    return colors;
  }
}
