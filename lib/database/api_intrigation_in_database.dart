import 'package:currency_converter/Models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coredata.dart';

class Intrigation extends StatefulWidget {
  const Intrigation({Key? key}) : super(key: key);

  @override
  _IntrigationState createState() => _IntrigationState();
}

class _IntrigationState extends State<Intrigation> {

  final dbHelper = DatabaseHelper.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: ElevatedButton(
          onPressed: (){
            database();
          },
          child: Text("Click!!"),

        ),
      ),

    );
  }

  void database() {



  }
}
