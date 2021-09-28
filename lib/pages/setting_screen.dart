import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Color> unlockedcolor = [Colors.green, Colors.blue, Colors.red, Colors.black26,Colors.yellow,Colors.cyan,Colors.green, Colors.blue, Colors.red, Colors.black26,Colors.yellow,Colors.cyan,Colors.green, Colors.blue, Colors.red, Colors.black26,Colors.yellow,Colors.cyan,Colors.green, Colors.blue, Colors.red, Colors.black26,Colors.yellow,Colors.cyan];
  Color color = Colors.red;

  bool isSwitched = false;
  bool checkBoxValue1 = true;
  bool checkBoxValue2 = false;
  bool fontsmall = false;
  bool fontmedium = true;
  bool fontlarge = false;
  bool displaycode = false;
  bool displaysymbol = true;
  bool displayflag = true;

  double _value = 1.0;
  int x = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(top: 5, left: 20),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff49599a), Color(0xff7986cb)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 1.5])),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, bottom: 13),
                child: Text("Remove Ads",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
              // margin: EdgeInsets.only(right: 20),
              width: width * .92,
              height: height * .078,
              padding:
                  const EdgeInsets.only(top: 10, left: 7, right: 2, bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                          text: "Support our project  with a small yearly",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        TextSpan(
                          text: "\n subscription",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        )
                      ])),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: 10,
                        margin: const EdgeInsets.only(top: 10, left: 2),
                        child: Switch(
                          inactiveTrackColor: Colors.grey,
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              // print(isSwitched);
                            });
                          },
                          activeTrackColor: const Color(0xff7986cb),
                          activeColor: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, bottom: 13, top: 20),
                child: Text("Select Language",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(

                // margin: EdgeInsets.only(right: 22),
                height: 55,
                width: width * .92,
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("English",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        //  SizedBox(width: 245 ,),
                        const Icon(
                          Icons.expand_more_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.white,
                      thickness: 1.2,
                    )
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(left: 10, bottom: 13, top: 20),
                child: Text("Color Selection",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            InkWell(
              onTap: () {
                print("vivek");
                Color pickerColor = const Color(0xff443a49);
                Color currentColor = const Color(0xff443a49);

                void changeColor(Color color) {
                  setState(() => pickerColor = color);
                }

                showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black45,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (BuildContext buildContext,
                        Animation animation, Animation secondaryAnimation) {
                      return DefaultTextStyle(
                        style: TextStyle(decoration: TextDecoration.none),
                        child: Center(
                          child: Container(
                              margin:const  EdgeInsets.only(
                                  top: 30, right: 10, bottom: 0, left: 10),
                              width: width,
                              height: height * 0.79,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 15, top: 30,bottom: 10),
                                    child: const Text(
                                      "Unlocked ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                  ),


                                SizedBox(
                                  height: 70,

                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                        // physics: NeverScrollableScrollPhysics(),
                                        // shrinkWrap: true,
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: 50,
                                            height: 0,
                                            margin: EdgeInsets.all(10),
                                            color: unlockedcolor[index],

                                            child: Text(""),
                                          );
                                        }),
                                ),
                                  Container(margin:EdgeInsets.all(20),child:Text("Locked",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)
                                    ,),
                                  Container(
                                    margin: EdgeInsets.only(left:40 ),

                                    child: BlockPicker(
                                      pickerColor: currentColor,
                                      onColorChanged: changeColor,

                                    ),
                                  ),

                                ],
                              )),
                        ),
                      );
                    });
              },
              child: Container(
                  // margin: EdgeInsets.only(right: 22),
                  height: 50,
                  width: width * .92,
                  padding:
                      EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff49599a), Color(0xff7986cb)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.1, 0.8]),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(width: 1.2, color: Colors.white),
                    ),
                    child: const Text(""),
                  )),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10, bottom: 13, top: 20),
                child: Text("Theme",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
                margin: const EdgeInsets.only(bottom: 24),
                height: 55,
                width: width * .92,
                padding:
                    EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: BorderSide(color: Colors.white),
                        value: checkBoxValue1,
                        onChanged: (value) {
                          setState(() {
                            if (checkBoxValue2) {
                              checkBoxValue1 = !checkBoxValue1;
                              checkBoxValue2 = !checkBoxValue2;
                            }
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        tristate: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Text("Light",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 50,
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: BorderSide(color: Colors.white),
                        value: checkBoxValue2,
                        onChanged: (value) {
                          setState(() {
                            if (checkBoxValue1) {
                              checkBoxValue2 = !checkBoxValue2;
                              checkBoxValue1 = !checkBoxValue1;
                            }
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        tristate: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Text(
                      "Dark",
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                    )
                  ],
                )),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "Widget Transparency  ",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 0, top: 15),
              height: height * .183,
              width: width * .92,
              padding: EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.31,
                          child: Slider(
                              activeColor: Colors.white,
                              inactiveColor: Colors.white,
                              min: 0,
                              max: 100,
                              value: _value,
                              onChanged: (value) {
                                setState(() {
                                  x = _value.toInt();
                                  _value = value;
                                });
                              }),
                        ),
                        Container(
                          width: 30,
                          child: Text(
                            "${x.toString()}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.5,
                    height: height * 1.9,
                    margin: EdgeInsets.only(left: 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.69),
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: const [
                              Color(0xff49599a),
                              Color(0xff7986cb)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.1, 1.5]),
                        border: Border.all(color: Colors.white, width: 3.9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.flag,
                              size: 30,
                            ),
                            Text(
                              "USD",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "/",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.flag,
                              size: 30,
                            ),
                            Text(
                              "EUR",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, top: 0),
                          child: Text("0.7895",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80, top: 0),
                          child: Text("-0.0400",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        AutoSizeText(
                          "  By: Currency.wiki",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          maxFontSize: 18,
                          minFontSize: 16,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, bottom: 13, top: 20),
                child: Text("Visual Size",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
                //  margin: EdgeInsets.only(right: 22),
                height: 50,
                width: width * .92,
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: BorderSide(color: Colors.white),
                        value: fontsmall,
                        onChanged: (value) {
                          setState(() {
                            if (fontlarge || fontmedium) {
                              fontsmall = true;
                              fontlarge = false;
                              fontmedium = false;
                            }
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        tristate: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Text("A",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: BorderSide(color: Colors.white),
                        value: fontmedium,
                        onChanged: (value) {
                          setState(() {
                            if (fontsmall || fontlarge) {
                              fontsmall = false;
                              fontlarge = false;
                              fontmedium = true;
                            }
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        tristate: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Text(
                      "A",
                      style:
                          GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: BorderSide(color: Colors.white),
                        value: fontlarge,
                        onChanged: (value) {
                          setState(() {
                            if (fontsmall || fontmedium) {
                              fontsmall = false;
                              fontlarge = true;
                              fontmedium = false;
                            }
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        tristate: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Text(
                      "A",
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 10, bottom: 5, top: 25),
                child: Text("App Logo Launcher",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                height: 85,
                width: 380,
                padding:
                    EdgeInsets.only(top: 15, left: 10, right: 20, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 5, left: 2),
                            child: Text("Multi-Convertor",
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        Container(
                          width: 30,
                          height: 10,
                          margin: EdgeInsets.only(top: 2, left: 2),
                          child: Switch(
                            inactiveTrackColor: Colors.grey,
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                // print(isSwitched);
                              });
                            },
                            activeTrackColor: Color(0xff7986cb),
                            activeColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Text("Will open multi-converter by default,Note"),
                    //     Text("NOTE:"),
                    //     Text("This feature only works with app logo")
                    //   ],
                    // )
                    RichText(
                        text: TextSpan(
                            text: "Will open multi-converter by default. ",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 11),
                            children: const <TextSpan>[
                          TextSpan(
                            text: "NOTE:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          TextSpan(
                            text:
                                "This feature only works with app logo launcher",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 11),
                          )
                        ])),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 10, bottom: 5, top: 25),
                child: Text("Display",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                height: height * .25,
                width: width * .92,
                padding: EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Text("Display Currency Code",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Switch(
                          inactiveTrackColor: Colors.grey,
                          value: displaycode,
                          onChanged: (value) {
                            setState(() {
                              if (displayflag) {
                                if (displaysymbol) {
                                  displaysymbol = false;
                                  displaycode = true;
                                } else
                                  displaycode = !displaycode;
                              } else if (displaycode) {
                              } else {
                                displaycode = true;
                                displaysymbol = false;
                              }

                              // print(isSwitched);
                            });
                          },
                          activeTrackColor: Color(0xff7986cb),
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Text("Display Currency Symbol",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Switch(
                          inactiveTrackColor: Colors.grey,
                          value: displaysymbol,
                          onChanged: (value) {
                            setState(() {
                              if (displayflag) {
                                if (displaycode) {
                                  displaysymbol = true;
                                  displaycode = false;
                                } else
                                  displaysymbol = !displaysymbol;
                              } else if (displaysymbol) {
                              } else if (displaysymbol && !displayflag) {
                              } else {
                                displaysymbol = true;
                                displaycode = false;
                              }
                            });
                          },
                          activeTrackColor: Color(0xff7986cb),
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Text("Display Currency Flag",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Switch(
                          inactiveTrackColor: Colors.grey,
                          value: displayflag,
                          onChanged: (value) {
                            setState(() {
                              if (!displaycode && !displaysymbol) {
                              } else
                                displayflag = !displayflag;
                              // print(isSwitched);
                            });
                          },
                          activeTrackColor: Color(0xff7986cb),
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 10, bottom: 13, top: 20),
                child: Text("Data Format",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.only(bottom: 24),
                height: 55,
                width: width * .92,
                padding:
                    EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: BorderSide(color: Colors.white),
                        value: checkBoxValue1,
                        onChanged: (value) {
                          setState(() {
                            if (checkBoxValue2) {
                              checkBoxValue1 = !checkBoxValue1;
                              checkBoxValue2 = !checkBoxValue2;
                            }
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        tristate: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Text("mm/dd/yy",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 35,
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        side: BorderSide(color: Colors.white),
                        value: checkBoxValue2,
                        onChanged: (value) {
                          setState(() {
                            if (checkBoxValue1) {
                              checkBoxValue2 = !checkBoxValue2;
                              checkBoxValue1 = !checkBoxValue1;
                            }
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        tristate: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Text(
                      "dd/mm/yy",
                      style:
                          GoogleFonts.roboto(fontSize: 16, color: Colors.white),
                    )
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
// content: SingleChildScrollView(
//child: BlockPicker(
//
//     pickerColor: currentColor,
//     onColorChanged: changeColor,
//
//   ),
// ),
