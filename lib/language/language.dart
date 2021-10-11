import 'package:currency_converter/pages/home/home_page.dart';
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
  List<String> language=[
    "ગુજરાત",
    "தமிழ்",
    "ქართული ",
    "Indonesia",
    "Catalan",
    "Deutsch ",
    "Eestikeel",
    "English",
    "Hindi",
    "Hrvatski",
    "Italiana",
    "Latvietis",
    "Magyar",
    "Marathi",
    "Melayu","Nederlands","Nepali","Norsk","Polskie","Portugues","Punjabi","Pyccknn","Romana","Slovenscina",
    "Svenska","Tieng","Turk","Ελληνικά","български","Українська","Հայերեն","עברית ","हिन्दी","বাংলা ",
    "తెలుగు","中国人","日本語",

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.79,
          child: Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, bottom: 0, left: 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: language.length,
                  itemBuilder: (context,index){

                return Column(
                  children: [
                    GestureDetector(
                      onTap:()async{
                        await context.setLocale(Locals.english);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext Context)=>MyTabBarWidget()), (route) => false);

                      },
                      child: Container(
                        margin: EdgeInsets.all(10),

                        width: 300,
                        height: 20,
                        child:Text("${language[index]}",style: TextStyle(fontSize: 18),)
                      ),
                    ),
                    Divider(color: Colors.black,),
                  ],
                );
              }),
        )
    )
    );
  }
}

