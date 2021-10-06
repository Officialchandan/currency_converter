

import 'package:flutter/material.dart';

class MyColors {
  static Color firstthemecolorgr = const Color(0xFF3350E0); //{ this is a color ,which change whole theme }

  static Color firstthemecolorgr1 = Colors.grey;  //{ this is a gradient color of theme which is always with  'firstthemecolorgr' }



  static Color calcuColor = Color(0xFFB2BBF5);  //{  this is a color of calculator button, we need to take this because some time it change some time not}

  static Color textColor =Colors.white;  //{ this is color of all text except textfield text}

  static Color insideTextFieldColor=Colors.black;  //{ this is a color of text,which is inside textField }

  static int textSize=2;  //{ This is integer value of size ,to increment or decrement the size of fonts}

  static bool checkBoxValue1=true;  //{ this boolean for date format dd/mm/yy}
    static bool checkBoxValue2=false;  //{ this boolean for date format mm/dd/yy}

    static bool datemm=false;  //{ this boolean for date format dd/mm/yy}
    static bool datedd=true;  //{ this boolean for date format mm/dd/yy}

  static bool fontsmall = false;
  static bool fontmedium = true;
  static  bool fontlarge = false;



}
