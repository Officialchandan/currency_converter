import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:currency_converter/Models/converter_data.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:share/share.dart';

import 'add_currency_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  bool isbool = true;
  double conversionRate = 0;
  String convertedDateTime = "";
  DateTime now = DateTime.now();
  ConverterData data = ConverterData();
  TextEditingController edtFrom = TextEditingController();
  TextEditingController edtTo = TextEditingController();
  String currencyCodeFrom = "";
  String currencyCodeTo = "";
  var calculatorTextSize;
  bool firstTime = true;
  bool isContainerVisible = false;

  Map<String, double> cresult = {};

  List<DataModel> selectedList = [];
  final dbHelper = DatabaseHelper.instance;
  StreamController<List<DataModel>> streamController = StreamController();
  StreamController<DataModel> dataController = StreamController();
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    getSelectedList();
  }

  void getSelectedList() async {
    firstTime = true;
    selectedList.clear();
    selectedList = await dbHelper.getSelectedData();
    debugPrint("selectedList-->$selectedList");
    streamController.add(selectedList);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    debugPrint("didChangeDependencies -> home tab ");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SecondScreen oldWidget) {
    debugPrint("didUpdateWidget$oldWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    calculatorTextSize = appheight * 0.050;
    print(calculatorTextSize);
    return WillPopScope(
      onWillPop: () async {
        if (isContainerVisible) {
          isContainerVisible = false;
          dataController.addError("error");
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
          height: appheight,
          width: appwidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              MyColors.colorPrimary.withOpacity(0.45),
              MyColors.colorPrimary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: appwidth * 0.14,
                        ),
                        Row(
                          children: [
                            Center(
                              child: Text(
                                "update".tr().toString(),
                                style: TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 18) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 18)
                                          : 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            MyColors.datemm
                                ? Center(
                                    child: Text(
                                      "${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year.toString()}",
                                      style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 18) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 18)
                                                : 18,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}",
                                      style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 18) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 18)
                                                : 18,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            _onShareWithEmptyOrigin(context);
                          },
                          child: Icon(
                            Icons.share,
                            color: MyColors.textColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    StreamBuilder<List<DataModel>>(
                        stream: streamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!.isNotEmpty) {
                            debugPrint(
                                "snapshot.data!.length-->${snapshot.data!.length}");
                            return ReorderableListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                debugPrint("index>$index");
                                DataModel model = snapshot.data![index];
                                if (index == 0 && firstTime) {
                                  model.controller.text = "1";
                                  calculateExchangeRate("1", 0, model);
                                  firstTime = false;
                                }

                                return Container(
                                  height: 45.0,
                                  padding:
                                      const EdgeInsets.only(right: 10, left: 5),
                                  key: ValueKey(model.code),
                                  margin: const EdgeInsets.only(top: 1.1),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: MyColors.textColor,
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyColors.displayflag &&
                                                MyColors.displaycode
                                            ? Container(
                                                width: 40,
                                                height: 40,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Image.asset(
                                                      model.image!,
                                                      fit: BoxFit.cover,
                                                    )))
                                            : Text(""),

                                        MyColors.displaycode
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8.0),
                                                height: 35.0,
                                                width: 60.0,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      MyColors.colorPrimary
                                                          .withOpacity(0.45),
                                                      MyColors.colorPrimary,
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    model.code,
                                                    style: TextStyle(
                                                      color: MyColors.textColor,
                                                      fontSize: MyColors
                                                              .fontsmall
                                                          ? (MyColors.textSize -
                                                                  18) *
                                                              (-1)
                                                          : MyColors.fontlarge
                                                              ? (MyColors
                                                                      .textSize +
                                                                  18)
                                                              : 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : //Currency Code
                                            MyColors.displayflag
                                                ? Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Image.asset(
                                                          model.image!,
                                                          fit: BoxFit.cover,
                                                        )))
                                                : //flag
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    height: 35.0,
                                                    width: 60.0,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          MyColors.colorPrimary
                                                              .withOpacity(
                                                                  0.45),
                                                          MyColors.colorPrimary,
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        model.symbol!,
                                                        style: TextStyle(
                                                          color: MyColors
                                                              .textColor,
                                                          fontSize: MyColors
                                                                  .fontsmall
                                                              ? (MyColors.textSize -
                                                                      18) *
                                                                  (-1)
                                                              : MyColors
                                                                      .fontlarge
                                                                  ? (MyColors
                                                                          .textSize +
                                                                      18)
                                                                  : 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ), //symbol
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        MyColors.displayflag &&
                                                MyColors.displaysymbol
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8.0),
                                                height: 35.0,
                                                width: 60.0,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      MyColors.colorPrimary
                                                          .withOpacity(0.45),
                                                      MyColors.colorPrimary,
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    model.symbol!,
                                                    style: TextStyle(
                                                      color: MyColors.textColor,
                                                      fontSize: MyColors
                                                              .fontsmall
                                                          ? (MyColors.textSize -
                                                                  18) *
                                                              (-1)
                                                          : MyColors.fontlarge
                                                              ? (MyColors
                                                                      .textSize +
                                                                  18)
                                                              : 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Text(""),

                                        Expanded(
                                          child: AutoSizeTextField(
                                            cursorColor: MyColors.colorPrimary,
                                            cursorWidth: 2.3,
                                            controller: model.controller,

                                            textAlign: TextAlign.center,
                                            // keyboardType: TextInputType.none,
                                            showCursor: true,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1.0,
                                                    top: 1.0,
                                                    bottom: 1.0),
                                                counterText: "",
                                                border: InputBorder.none),
                                            style: TextStyle(
                                              color: MyColors.colorPrimary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: MyColors.fontsmall
                                                  ? (MyColors.textSize - 18) *
                                                      (-1)
                                                  : MyColors.fontlarge
                                                      ? (MyColors.textSize + 18)
                                                      : 18,
                                            ),
                                            onChanged: (String text) {
                                              text = model.controller.text;

                                              calculateExchangeRate(
                                                  text, index, model);
                                            },
                                            onTap: () async {
                                              isContainerVisible = true;
                                              dataController.add(model);
                                              // currentIndex = index;

                                              // setState(() {});
                                              //      showCalculator(
                                              //     context, model.controller, (text) {
                                              //   calculateExchangeRate(
                                              //       text, index, model);
                                              // });
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/up-down.png",
                                                scale: 9,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  model.selected = 0;
                                                  dbHelper
                                                      .update(model.toMap());
                                                  selectedList.removeAt(index);
                                                  streamController
                                                      .add(selectedList);
                                                },
                                                child: Image.asset(
                                                  "assets/images/cross.png",
                                                  scale: 9,
                                                  color: MyColors.colorPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              onReorder: (oldIndex, newIndex) {
                                if (newIndex > oldIndex) {
                                  newIndex = newIndex - 1;
                                }
                                final element = selectedList.removeAt(oldIndex);
                                selectedList.insert(newIndex, element);
                                streamController.add(selectedList);
                              },
                            );
                          }
                          return Container();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: StreamBuilder<DataModel>(
          stream: dataController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return calculator(context, snapshot.data!.controller,
                  (changeValue) {
                int i = selectedList.indexWhere(
                    (element) => element.code == snapshot.data!.code);
                if (i != -1) {
                  calculateExchangeRate(changeValue, i, snapshot.data!);
                }
              });
            }
            return SizedBox(
              width: 0,
              height: 0,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.textColor,
          onPressed: () async {
            streamController.add([]);
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddCurrency()));
            getSelectedList();
          },
          child: Icon(
            Icons.add,
            size: 40,
            color: MyColors.colorPrimary,
          ),
        ),
      ),
    );
  }

  showCalculator(BuildContext context, TextEditingController controller,
      Function(String changeValue) onChange) {
    showModalBottomSheet(
        barrierColor: Colors.transparent,
        isDismissible: true,
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
                equation = equation.substring(0, equation.length - 1);
                if (equation == "") {
                  equation = "0";
                }
              } else if (buttonText == "=") {
                equationFontSize = 38.0;
                resultFontSize = 48.0;
                isbool = false;

                expression = equation;
                expression = expression.replaceAll('×', '*');
                expression = expression.replaceAll('÷', '/');

                try {
                  Parser p = Parser();
                  Expression exp = p.parse(expression);

                  ContextModel cm = ContextModel();
                  result = '${exp.evaluate(EvaluationType.REAL, cm)}';
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
              isbool ? controller.text = equation : controller.text = result;
              isbool ? onChange(equation) : onChange(result);

              isbool = true;
            });
          }

          Widget buildButton(String buttonText, double buttonHeight,
              Color buttonColor, double buttonTexth) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.left,
                ),
                height: MediaQuery.of(context).size.height *
                        0.1 /
                        1.5 *
                        buttonHeight +
                    2.6,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    MyColors.colorPrimary.withOpacity(.4),
                    MyColors.colorPrimary.withOpacity(.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  //stops: [0.0,0.0]
                )),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(
                            color: MyColors.colorPrimary,
                            width: 0.6,
                            style: BorderStyle.solid)),
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () => buttonPressed(buttonText),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          buttonText,
                          style: TextStyle(
                              fontSize: buttonTexth,
                              fontWeight: FontWeight.normal,
                              color: MyColors.textColor),
                        ),
                      ),
                    )),
              ),
            );
          }

          return SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: <Widget>[
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Table(
                          children: [
                            TableRow(children: [
                              buildButton("%", 1, MyColors.calcuColor, 30),
                              buildButton("/", 1, MyColors.calcuColor, 25),
                              buildButton("×", 1, MyColors.calcuColor, 35),
                            ]),
                            TableRow(children: [
                              buildButton("1", 1, MyColors.calcuColor, 25),
                              buildButton("2", 1, MyColors.calcuColor, 25),
                              buildButton("3", 1, MyColors.calcuColor, 25),
                            ]),
                            TableRow(children: [
                              buildButton("4", 1, MyColors.calcuColor, 25),
                              buildButton("5", 1, MyColors.calcuColor, 25),
                              buildButton("6", 1, MyColors.calcuColor, 25),
                            ]),
                            TableRow(children: [
                              buildButton("7", 1, MyColors.calcuColor, 25),
                              buildButton("8", 1, MyColors.calcuColor, 25),
                              buildButton("9", 1, MyColors.calcuColor, 25),
                            ]),
                            TableRow(children: [
                              buildButton(".", 1, MyColors.calcuColor, 25),
                              buildButton("0", 1, MyColors.calcuColor, 25),
                              buildButton("c", 1, MyColors.calcuColor, 25),
                            ]),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Table(children: [
                            TableRow(children: [
                              InkWell(
                                  onLongPress: () {
                                    setState(() {
                                      equation == "";
                                    });
                                  },
                                  child: buildButton(
                                      "⌫", 1, MyColors.calcuColor, 30)),
                            ]),
                            TableRow(children: [
                              buildButton("-", 1, MyColors.calcuColor,
                                  calculatorTextSize),
                            ]),
                            TableRow(children: [
                              buildButton("+", 1, MyColors.calcuColor, 30),
                            ]),
                            TableRow(
                              children: [
                                Center(
                                    child: buildButton("=", 2 * 1.02,
                                        MyColors.calcuColor, 40)),
                              ],
                            ),
                          ]))
                    ],
                  ),
                ],
              ));
        });
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share(
        "https://play.google.com/store/apps/details?id=com.tencent.ig");
  }

  void calculateExchangeRate(String text, int index, DataModel model) async {
    debugPrint("onchange$text");
    double d = double.parse(text);
    debugPrint("d$d");
    for (DataModel element in selectedList) {
      if (element.code != model.code) {
        double conversionRate = ((double.parse(model.value) * 100) /
                (double.parse(element.value) * 100)) *
            (d);

        debugPrint("conversionRate->$conversionRate");
        String m = await getFormatText(
            conversionRate.toStringAsFixed(MyColors.decimalFormat));

        element.controller.text = m;
        element.exchangeValue = m;
      }
    }

    streamController.add(selectedList);
  }

  String getFormatText(String s) {
    String text1 = "";
    debugPrint("MyColors.decimalformat-->${MyColors.decimalFormat}");
    debugPrint("getFormatText-->$s");

    int i = MyColors.monetaryFormat;
    debugPrint("monetaryFormat-->$i");
    int afterdecimal = MyColors.decimalFormat;

    // double amount =
    //       double.parse(s);
    //
    // debugPrint("amount-->$amount");
    CurrencyTextInputFormatter mformat = CurrencyTextInputFormatter(
      decimalDigits: afterdecimal,
      symbol: "",
    );
    if (i == 1) {
      text1 = mformat.format(s.replaceAll(".", ""));

      text1 = text1.replaceAll(",", ",");

      text1 = text1.replaceAll(".", ".");

      return text1;
    } else if (i == 2) {
      text1 = mformat.format(s.replaceAll(".", ""));
      log(text1);
      text1 = text1.replaceAll(".", " ");
      log(text1);
      text1 = text1.replaceAll(",", ".");
      log(text1);
      text1 = text1.replaceAll(" ", ",");
      return text1;
      //text = text.replaceFirstMapped(".", (match) => "1");
    } else if (i == 3) {
      text1 = mformat.format(s.replaceAll(".", ""));
      text1 = text1.replaceAll(".", "=");
      log(text1);
      text1 = text1.replaceAll(",", ".");
      log(text1);
      text1 = text1.replaceAll(".", " ");
      text1 = text1.replaceAll("=", ".");

      log(text1);
      return text1;
    } else if (i == 4) {
      text1 = mformat.format(s.replaceAll(".", ""));
      log(text1);
      text1 = text1.replaceAll(",", " ");
      log(text1);
      text1 = text1.replaceAll(".", ",");
      log(text1);
      return text1;
    }
    return text1;
  }

  Widget calculator(BuildContext context, TextEditingController controller,
      Function(String changeValue) onChange) {
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
          equation = equation.substring(0, equation.length - 1);
          if (equation == "") {
            equation = "0";
          }
        } else if (buttonText == "=") {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          isbool = false;

          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
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
        isbool ? controller.text = equation : controller.text = result;
        isbool ? onChange(equation) : onChange(result);

        isbool = true;
      });
    }

    Widget buildButton(String buttonText, double buttonHeight,
        Color buttonColor, double buttonTexth) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.left,
          ),
          height:
              MediaQuery.of(context).size.height * 0.1 / 1.5 * buttonHeight +
                  2.6,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              MyColors.colorPrimary.withOpacity(.4),
              MyColors.colorPrimary.withOpacity(.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            //stops: [0.0,0.0]
          )),
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                      color: MyColors.colorPrimary,
                      width: 0.6,
                      style: BorderStyle.solid)),
              padding: const EdgeInsets.all(0.0),
              onPressed: () => buttonPressed(buttonText),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                        fontSize: buttonTexth,
                        fontWeight: FontWeight.normal,
                        color: MyColors.textColor),
                  ),
                ),
              )),
        ),
      );
    }

    return SizedBox(
        width: MediaQuery.of(context).size.width * .75,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          children: <Widget>[
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("%", 1, MyColors.calcuColor, 30),
                        buildButton("/", 1, MyColors.calcuColor, 25),
                        buildButton("×", 1, MyColors.calcuColor, 35),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, MyColors.calcuColor, 25),
                        buildButton("2", 1, MyColors.calcuColor, 25),
                        buildButton("3", 1, MyColors.calcuColor, 25),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, MyColors.calcuColor, 25),
                        buildButton("5", 1, MyColors.calcuColor, 25),
                        buildButton("6", 1, MyColors.calcuColor, 25),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, MyColors.calcuColor, 25),
                        buildButton("8", 1, MyColors.calcuColor, 25),
                        buildButton("9", 1, MyColors.calcuColor, 25),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, MyColors.calcuColor, 25),
                        buildButton("0", 1, MyColors.calcuColor, 25),
                        buildButton("c", 1, MyColors.calcuColor, 25),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Table(children: [
                      TableRow(children: [
                        InkWell(
                            onLongPress: () {
                              setState(() {
                                equation == "";
                              });
                            },
                            child:
                                buildButton("⌫", 1, MyColors.calcuColor, 30)),
                      ]),
                      TableRow(children: [
                        buildButton(
                            "-", 1, MyColors.calcuColor, calculatorTextSize),
                      ]),
                      TableRow(children: [
                        buildButton("+", 1, MyColors.calcuColor, 30),
                      ]),
                      TableRow(
                        children: [
                          Center(
                              child: buildButton(
                                  "=", 2 * 1.02, MyColors.calcuColor, 40)),
                        ],
                      ),
                    ]))
              ],
            ),
          ],
        ));
  }
}
