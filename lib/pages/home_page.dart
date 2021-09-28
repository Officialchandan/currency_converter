import 'dart:core';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/second_screen.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

String equation = "0";
String result = "0";
String expression = "";
double equationFontSize = 38.0;
double resultFontSize = 48.0;
bool isbool = true;
TextEditingController tx1 = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Scaffold(
        body: MyTabBarWidget(),
      ),
    );
  }
}

class MyTabBarWidget extends StatefulWidget {
  const MyTabBarWidget({Key? key}) : super(key: key);

  @override
  State<MyTabBarWidget> createState() => _MyTabBarWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyTabBarWidgetState extends State<MyTabBarWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String textCurrency = "USA";
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _tabController,
              indicatorWeight: 2.5,

              indicatorColor: Colors.white,

              // labelColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Image.asset("assets/tab-ic1.png", scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic2.png", scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic3.png", scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic4.png", scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic5.png", scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic6.png", scale: 4),
                ),
              ],
            ),
          ],
        ),
      ),

      ///***Backraunde colors */
      body: Container(
        height: appheight,
        width: appwidth,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            MyColors.firstthemecolorgr1,
            MyColors.firstthemecolorgr,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: TabBarView(
          controller: _tabController,
          children: const [
            TapHome(),
            SecondScreen(),
            Center(
              child: Text("It's sunny here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
            SettingScreen(),
          ],
        ),
      ),
    );
  }
}

class TapHome extends StatefulWidget {
  const TapHome({Key? key}) : super(key: key);

  @override
  _TapHomeState createState() => _TapHomeState();
}

class _TapHomeState extends State<TapHome> {
  @override
  Widget build(BuildContext context) {
    String textCurrency = "USA";
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.red,
                width: appwidth - 20,

                child: Row(
                  children: const <Widget>[
                    SizedBox(
                      width: 110,
                    ),
                    Text("Updated:"),
                    SizedBox(
                      width: 5,
                    ),
                    Text("09/23/2021"),
                    SizedBox(
                      width: 50.0,
                    ),
                    Icon(
                      Icons.share,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                width: appwidth - 20,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        height: 35.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              MyColors.firstthemecolorgr1,
                              MyColors.firstthemecolorgr,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            "$textCurrency!",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.24,
                        // width: 150,
                        child: TextField(
                          controller: tx1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.none,
                          showCursor: true,
                          readOnly: true,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          onTap: () {
                            showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                // isDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  buttonPressed(String buttonText) {
                                    setState(() {
                                      if (buttonText == "C") {
                                        isbool = true;
                                        equation = "0";
                                        isbool = false;
                                        equationFontSize = 38.0;
                                        resultFontSize = 48.0;
                                      } else if (buttonText == "⌫") {
                                        equationFontSize = 48.0;
                                        resultFontSize = 38.0;
                                        equation = equation.substring(
                                            0, equation.length - 1);
                                        if (equation == "") {
                                          equation = "0";
                                        }
                                      } else if (buttonText == "=") {
                                        equationFontSize = 38.0;
                                        resultFontSize = 48.0;
                                        isbool = false;

                                        expression = equation;
                                        expression =
                                            expression.replaceAll('×', '*');
                                        expression =
                                            expression.replaceAll('÷', '/');

                                        try {
                                          Parser p = Parser();
                                          Expression exp = p.parse(expression);

                                          ContextModel cm = ContextModel();
                                          result =
                                              '${exp.evaluate(EvaluationType.REAL, cm)}';
                                        } catch (e) {
                                          result = "";
                                        }
                                      } else {
                                        equationFontSize = 48.0;
                                        resultFontSize = 38.0;
                                        if (equation == "0") {
                                          equation = buttonText;
                                        } else {
                                          equation = equation + buttonText;
                                        }
                                      }
                                      isbool
                                          ? tx1.text = equation
                                          : tx1.text = result;
                                      isbool = true;
                                    });
                                  }

                                  Widget buildButton(String buttonText,
                                      double buttonHeight, Color buttonColor) {
                                    return SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .left,
                                        ),
                                        //**Alline height */
                                        //This is grate
                                        height:
                                            MediaQuery.of(context).size.height *
                                                    0.1 /
                                                    1.5 *
                                                    buttonHeight +
                                                2.6,

                                        color: buttonColor,
                                        child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                side: const BorderSide(
                                                    color: MyColors
                                                        .firstthemecolorgr,
                                                    width: 0.3,
                                                    style: BorderStyle.solid)),
                                            padding: const EdgeInsets.all(10.0),
                                            onPressed: () =>
                                                buttonPressed(buttonText),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  buttonText,
                                                  style: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                      ),
                                    );
                                  }

                                  return Container(
                                      width: MediaQuery.of(context).size.width *
                                          .75,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .75,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.35,
                                                child: Table(
                                                  children: [
                                                    TableRow(children: [
                                                      buildButton(
                                                          "%",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "/",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "×",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                    TableRow(children: [
                                                      buildButton(
                                                          "1",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "2",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "3",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                    TableRow(children: [
                                                      buildButton(
                                                          "4",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "5",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "6",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                    TableRow(children: [
                                                      buildButton(
                                                          "7",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "8",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "9",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                    TableRow(children: [
                                                      buildButton(
                                                          ".",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "0",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                      buildButton(
                                                          "C",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: Table(children: [
                                                    TableRow(children: [
                                                      buildButton(
                                                          "⌫",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                    TableRow(children: [
                                                      buildButton(
                                                          "-",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                    TableRow(children: [
                                                      buildButton(
                                                          "+",
                                                          1,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                    TableRow(children: [
                                                      buildButton(
                                                          "=",
                                                          2,
                                                          const Color(
                                                              0xFFB2BBF5)),
                                                    ]),
                                                  ]))
                                            ],
                                          ),
                                        ],
                                      ));
                                });
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Center(
                        child: Icon(
                          Icons.compare_arrows_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: appwidth * 0.45,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Align(
                          alignment: Alignment(0.9, 0),
                          child: Icon(Icons.keyboard_arrow_down)),
                    ),
                  ),
                  // const Expanded(
                  //   child: SizedBox(
                  //     width: 13.5,
                  //   ),
                  // ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: appwidth * 0.45,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Align(
                        alignment: const Alignment(0.9, 0),
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 25.0,
              ),
              const Center(
                child: Text("0 EUR"),
              ),

              ///************************************Calcu */
            ],
          ),
        ),
      ),
    );
  }
}
