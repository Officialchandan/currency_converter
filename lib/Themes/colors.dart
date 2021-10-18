


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyColors {




  static Color colorPrimary =  Color(0xff4e7dcb ); //{ this is a color ,which change whole theme }
  static Color firstthemecolorgr1 = colorPrimary.withOpacity(0.5);  //{ this is a gradient color of theme which is always with  'firstthemecolorgr' }

  static Color calcuColor =colorPrimary;  //{  this is a color of calculator button, we need to take this because some time it change some time not}
  static Color textColor =Colors.white;  //{ this is color of all text except textfield text}
  static Color insideTextFieldColor=Colors.black; //{ this is a color of text,which is inside textField }

  static bool checkBoxValue1 = true; //{ this boolean for date format dd/mm/yy}
  static bool checkBoxValue2 = false; //{ this boolean for date format mm/dd/yy}

  static bool datemm=false;  //{ this boolean for date format dd/mm/yy}
  static bool datedd=true;  //{ this boolean for date format mm/dd/yy}

  static int textSize=2;  //{ This is integer value of size ,to increment or decrement the size of fonts}
  static bool fontsmall = false;  //{ this is for doing small font by a variable}
  static bool fontmedium = true;  //{ this is also same like about but it is for medium font and it will be by default}
  static  bool fontlarge = false;  //{ this is for large font }

  static int decimalformat= 2;
  static int monetaryformat=2;

  static List <bool> boolDecimalFormate=[false,true,false,false,false,false];
  static List <bool> boolMonetaryFormate=[false,true,false,false];
static int count =0;





}
