import 'dart:async';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/second_screen.dart';
import 'package:currency_converter/pages/setting_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: (Scaffold(
        body: MyTabBarWidget(),
      )),
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
          children: [
            const TapHome(),
            const SecondScreen(),
            const Center(
              child: Text("It's sunny here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
            SettingScreen(onThemeChange),
          ],
        ),
      ),
    );
  }

  void onThemeChange() {

    debugPrint("onTheme change -->");
    setState(() {});
  }
}

class TapHome extends StatefulWidget {
  const TapHome({Key? key}) : super(key: key);

  @override
  _TapHomeState createState() => _TapHomeState();
}

class _TapHomeState extends State<TapHome> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  bool isbool = true;
  bool arrowPosition = false;
  bool arrowPositionTwo = false;
  bool indexTrue = true;
  bool starIndex = false;
  // StreamController<List<String>> streamController = StreamController();

  List<String> mylist = [];

  List<String> itemlist = [
    "LED Submersible Lights",
    "Portable Projector",
    "Bluetooth Speaker",
    "Smart Watch",
    "Temporary Tattoos",
    "Bookends",
    "Vegetable Chopper",
    "Neck Massager",
    "Facial Cleanser",
    "Back Cushion",
    "Portable Blender",
  ];

  TextEditingController tx1 = TextEditingController();
  bool _isContainerVisible = false;
  bool _isContainerVisibleTwo = false;
  void getdata() async {
    mylist = await itemlist;
    // streamController.add(mylist);
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  void dispose() {
    // streamController.close();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    starIndex = true;

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String textCurrency = "USA";
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.firstthemecolorgr,
      body: Container(
        height: appheight,
        width: appwidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            MyColors.firstthemecolorgr1,
            MyColors.firstthemecolorgr,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
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
                            gradient: LinearGradient(
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
                                            Expression exp =
                                                p.parse(expression);

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

                                    Widget buildButton(
                                        String buttonText,
                                        double buttonHeight,
                                        Color buttonColor) {
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
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1 /
                                                  1.5 *
                                                  buttonHeight +
                                              2.6,

                                          color: buttonColor,
                                          child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  side: BorderSide(
                                                      color: MyColors
                                                          .firstthemecolorgr,
                                                      width: 0.3,
                                                      style:
                                                          BorderStyle.solid)),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              onPressed: () =>
                                                  buttonPressed(buttonText),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .75,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .75,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                    child: Table(
                                                      children: [
                                                        TableRow(children: [
                                                          buildButton(
                                                              "%",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "/",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "×",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                        TableRow(children: [
                                                          buildButton(
                                                              "1",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "2",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "3",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                        TableRow(children: [
                                                          buildButton(
                                                              "4",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "5",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "6",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                        TableRow(children: [
                                                          buildButton(
                                                              "7",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "8",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "9",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                        TableRow(children: [
                                                          buildButton(
                                                              ".",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "0",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                          buildButton(
                                                              "C",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: Table(children: [
                                                        TableRow(children: [
                                                          buildButton(
                                                              "⌫",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                        TableRow(children: [
                                                          buildButton(
                                                              "-",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                        TableRow(children: [
                                                          buildButton(
                                                              "+",
                                                              1,
                                                              MyColors
                                                                  .calcuColor),
                                                        ]),
                                                        TableRow(children: [
                                                          buildButton(
                                                              "=",
                                                              2,
                                                              MyColors
                                                                  .calcuColor),
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
                        onTap: () {
                          _isContainerVisible = true;
                          setState(() {
                            debugPrint("Hello");

                            arrowPosition = !arrowPosition;
                          });
                          debugPrint("Hello1");
                          // OpenContaner(_isContainerVisible, itemlist);

                          debugPrint("Hello2");
                          // log("===>1$_isContainerVisible");
                          // _isContainerVisible == false
                          //     ? OpenContaner(_isContainerVisible, itemlist)
                          //     : OpenContaner(_isContainerVisible, itemlist);
                          // log("===>2$_isContainerVisible");
                        },
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
                        onTap: () {
                          _isContainerVisible = false;
                          _isContainerVisibleTwo = true;
                          setState(() {
                            debugPrint("Hello");
                            //  _isContainerVisibleTwo = !_isContainerVisibleTwo;
                            arrowPositionTwo = !arrowPositionTwo;
                          });
                          debugPrint("Hello1");
                          OpenContaner(_isContainerVisibleTwo, itemlist);

                                debugPrint("Hello2");
                                log("===>1$_isContainerVisibleTwo");
                                _isContainerVisibleTwo == false
                                    ? OpenContaner(
                                        _isContainerVisibleTwo, itemlist)
                                    : OpenContaner(
                                        _isContainerVisibleTwo, itemlist);
                                log("===>2$_isContainerVisibleTwo");
                              },
                              child: const Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  OpenContaner(_isContainerVisible, itemlist),
                  // OpenContanerTwo(_isContainerVisibleTwo),

                  const SizedBox(
                    height: 25.0,
                  ),
                  const Center(
                    //***Currency Text*/
                    child: Text("0 EUR"),
                  ),

                  ///************************************Conte */
                ],
              ),
              _isContainerVisible
                  ? const Positioned(
                      top: 138,
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 50,
                        color: Colors.white,
                      ))
                  : Container(),
              _isContainerVisibleTwo
                  ? Positioned(
                      top: 138.0,
                      left: 175.0,
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 50,
                        color: Colors.white,
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class OpenContaner extends StatefulWidget {
  OpenContaner(this._isContainerVisible, this.mylist);
  final bool _isContainerVisible;
  final List<String> mylist;

  @override
  State<OpenContaner> createState() => _OpenContanerState();
}

class _OpenContanerState extends State<OpenContaner> {
  StreamController<List<String>> streamController = StreamController();
  bool starIndex = false;
  @override
  Widget build(BuildContext context) {
    log("===>${widget._isContainerVisible}");
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.0),
          ),
          duration: const Duration(seconds: 0),
          height: widget._isContainerVisible
              ? MediaQuery.of(context).size.height * 0.57
              : 0.0,
          width: widget._isContainerVisible
              ? MediaQuery.of(context).size.width
              : 0.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: TextField(
                  onChanged: (String text) {
                    List<String> searchList = [];

                    for (var element in widget.mylist) {
                      if (element
                          .toString()
                          .toLowerCase()
                          .contains(text.trim().toLowerCase())) {
                        searchList.add(element);
                      }
                    }
                    streamController.add(searchList);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 22,
                      color: Colors.black,
                    ),
                    hintText: "Search",
                    hintStyle:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                child: StreamBuilder<List<String>>(
                    stream: streamController.stream,
                    initialData: widget.mylist,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("${snapshot.data}");
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.image),
                                title: Row(
                                  children: [
                                    Text(
                                      "${snapshot.data![index]}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(""),
                                  ],
                                ),
                                trailing: starIndex
                                    ? const Icon(
                                        Icons.star_sharp,
                                        size: 30.0,
                                      )
                                    : const Icon(
                                        Icons.star,
                                        size: 30.0,
                                      ),
                              );
                            });
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      }

                      return const Center(
                        child: Text("no data"),
                      );

                      // child: ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: itemlist.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return ListTile(
                      //         leading: const Icon(Icons.list),
                      //         title: Row(
                      //           children:  [
                      //             Text("${itemlist[index]}"),
                      //             const SizedBox(
                      //               height: 5.0,
                      //             ),
                      //             const Text("List item"),
                      //           ],
                      //         ),
                      //         trailing: const Icon(
                      //           Icons.star_border,
                      //           size: 20,
                      //         ),
                      //       );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OpenContanerTwo extends StatelessWidget {
  OpenContanerTwo(
    this._isContainerVisibleTwo,
  );
  final bool _isContainerVisibleTwo;

  @override
  Widget build(BuildContext context) {
    log("===>$_isContainerVisibleTwo");
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.0),
          ),
          duration: const Duration(seconds: 0),
          height: _isContainerVisibleTwo
              ? MediaQuery.of(context).size.height * 0.57
              : 0.0,
          width:
              _isContainerVisibleTwo ? MediaQuery.of(context).size.width : 0.0,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 22,
                      color: Colors.black,
                    ),
                    hintText: "Search",
                    hintStyle:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.list),
                        title: Row(
                          children: const [
                            Text("List item"),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text("List item"),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.star_border,
                          size: 20,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
