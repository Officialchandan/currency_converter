import 'package:currency_converter/utils/locals.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.79,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(
                    top: 15, right: 10, bottom: 0, left: 10),
                child: Column(
                  children: [
                    ElevatedButton(onPressed: () async {
                      await context.setLocale(Locals.english);
                      setState(() {

                      });


                    }, child: Text("English")),
                    ElevatedButton(onPressed: () async{
                      await context.setLocale(Locals.hindi);
                      setState(() {

                      });


                    }, child: Text("Hindi"))
                  ],
                )),
          ]),
        ));
  }
}
