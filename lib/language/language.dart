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



  @override
  Widget build(BuildContext context) {
    return Center(


        child: DefaultTextStyle(
          style: const TextStyle(decoration: TextDecoration.none),

          child: Container(
              margin: const EdgeInsets.only(
                  top: 0, right: 10, bottom: 0, left: 10),

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.79,
            child: Container(
                margin: const EdgeInsets.only(
                    top: 15, right: 10, bottom: 0, left: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Locals.language.length,
                    itemBuilder: (context,index){

                  return Column(
                    children: [
                      GestureDetector(
                        onTap:()async{
                          String name=Locals.language[index].keys.first;
                          print("language=>>> $name");
                           await context.setLocale(Locals.language[index].values.first);
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context )=>MyTabBarWidget()), (route) => false);


                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(7),

                              width: 300,
                              height: 30,
                              child:Text(Locals.language[index].keys.first,style: TextStyle(fontSize: 18,color: Colors.black),)
                            ),

                          ],
                        ),
                      ),
                      Divider(color: Colors.black,),
                    ],
                  );
                }),
          )
    ),
        )
    );
  }
}

