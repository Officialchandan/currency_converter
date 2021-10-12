import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:io';

import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static final _dbName = 'currencyconverter.db';
  static final _dbVersion = 1;
  static final tableName = "conversion";
  static final  ColumnId="id";
  static final countryCode = "countryCode";
  static final countryImage = "countryImage";
  static final currencyValue = "currencyValue";
  static final favCountry = "favCountry";
  static final selectedCountry = "selectedCountry";


  DatabaseHelper._p();

  //static DatabaseHelper instance = DatabaseHelper._p();

  static final DatabaseHelper instance = new DatabaseHelper._p();

  static  Database? _database;

  Future<Database> get database async {

    if (_database != null) return _database!;
    _database = await initdb();
    return _database!;
  }
  initdb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return  await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tableName (
            $ColumnId INTEGER PRIMARY KEY,
            $countryCode TEXT NOT NULL,
            $countryImage TEXT NOT NULL,
            $currencyValue TEXT NOT NULL,
            $favCountry INTEGER NOT NULL,
            $selectedCountry INTEGER NOT NULL
            )'''
    );
  }
  Future<int> insert(Map<String, dynamic> row) async {
    print("data->$row");
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data =  await db.query(tableName);

    print("data--->$data");

    return data;

  }
  Future<int> update(Map<String, dynamic> row,int id) async {
    Database db = await instance.database;
    // int id = row[ColumnId];
    return await db.update(tableName, row, where: '$ColumnId =  ?', whereArgs: [id]);
  }



}