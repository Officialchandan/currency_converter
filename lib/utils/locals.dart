import 'package:flutter/material.dart';

class Locals {
  static const english = Locale('en');
  static const hindi = Locale('hi');
  static const nepali = Locale('ne');
  static const gujarati = Locale('gu');
  static const catalan = Locale('ca');
  static const hrvatski = Locale('hr');
  static const italiana = Locale('it');
  static const latvietis = Locale('lv');
  static const magyar = Locale('hu');
  static const Deutsch = Locale('ach');
  static const Tamil = Locale('ta');

  static const Georgian = Locale('ka');
  static const Indonesia = Locale('id');
  static const marathi = Locale('mr');

  static const melayu = Locale('ms');
  static const nederlands = Locale('nl');

  static const norsk = Locale('nn');
  static const polskie = Locale('pl');
  static const portugues = Locale('pt');
  static const punjabi = Locale('pa');
  static const pyccknn = Locale('ru');
  static const slovenscina = Locale('sl');
  static const svenska = Locale('sv');
  static const romana = Locale('ro');
  static const tieng = Locale('vi');
  static const turk = Locale('tr');
  static const greek = Locale('grc');

  static const Bulgarians = Locale('bg', '');
  static const Ukraine = Locale('uk');
  // static const Armenian = Locale('arm');
  // static const Hebrew = Locale('he');
  //
  // static const Afar = Locale('aa');

  // static const Chinese = Locale('zh_Hant');

  static List<Map<String, Locale>> language = [
    {"English": Locals.english},
    {"hrvatski  ": Locals.hrvatski},
    {"Italiano  ": Locals.italiana},
    {"latvietis  ": Locals.latvietis},
    {"magyar  ": Locals.magyar},
    {"Deutsch  ": Locals.Deutsch},
    {"தமிழ்  ": Locals.Tamil},
    {"ქართული  ": Locals.Georgian},
    {"Indonesia  ": Locals.Indonesia},
    {"मराठी  ": Locals.marathi},
    {"melayu  ": Locals.melayu},
    {"norsk  ": Locals.norsk},
    {"polskie  ": Locals.polskie},
    {"nederlands  ": Locals.nederlands},
    {"portugues  ": Locals.portugues},
    {"ਪੰਜਾਬੀ  ": Locals.punjabi},
    {"slovenscina  ": Locals.slovenscina},
    {"svenska  ": Locals.svenska},
    {"romana  ": Locals.romana},
    {"tieng viet  ": Locals.tieng},
    {"turk  ": Locals.turk},
    {"Ελληνικά  ": Locals.greek},
    {"български  ": Locals.Bulgarians},
    {"Українська  ": Locals.Ukraine},
    {
      "हिंदी": Locals.hindi,
    },
    {"नेपाली": Locals.nepali},
    {"ગુજરાતી": Locals.gujarati},
    // {"Հայերեն  ": Locals.Armenian},
    // {"Hebrew  ": Locals.Hebrew},
    // {"বাংলা  ": Locals.Afar},
    // {"中国人  ": Locals.Chinese},
  ];

  static const supportedLang = [
    english,
    hindi,
    nepali,
    gujarati,
    catalan,
    hrvatski,
    latvietis,
    magyar,
    Deutsch,
    Tamil,
    marathi,
    polskie,
    nederlands,
    portugues,
    punjabi,
    pyccknn,
    slovenscina,
    svenska,
    romana,
    tieng,
    turk,
    greek,
    Ukraine,
    // Armenian,
    // Hebrew,

    // Bulgarians,
    // norsk,
    // Georgian,
    // melayu,
  ];
}
