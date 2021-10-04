import 'dart:developer';
import 'dart:io';

import 'package:currency_converter/Models/converter_data.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'currency_from_widget.dart';
import 'currency_to_widget.dart';

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
  bool contanerIndex = true;
  String z = "";
  double conversionRate = 0;

  TextEditingController edtCurrency = TextEditingController();
  TextEditingController calculateCurrency = TextEditingController();
  TextEditingController edtFrom = TextEditingController();
  TextEditingController edtTo = TextEditingController();
  bool _isContainerVisible = false;
  bool _isContainerVisibleTwo = false;
  String convertedDateTime = "";
  DateTime now = DateTime.now();

  String currencyCodeFrom = "USD";
  String currencyCodeTo = "EUR";
  Map<String, double> cresult = {};
  @override
  void initState() {
    super.initState();
    setState(() {
      getConverterAPI(
          currencyCodeFrom, currencyCodeTo, conversionRate.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // color: Colors.red,
                    width: appwidth - 20,

                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 115,
                        ),
                        const Text("Updated:"),
                        const SizedBox(
                          width: 5,
                        ),
                        MyColors.datemm
                            ? Text(
                                "${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year.toString()}")
                            : Text(
                                "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}"),
                        const SizedBox(
                          width: 50.0,
                        ),
                        const Icon(
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
                      color: MyColors.textColor,
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
                                currencyCodeFrom,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height * 0.24,
                            // width: 150,
                            child: TextField(
                              controller: calculateCurrency,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                              showCursor: true,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              onTap: () {
                                showCalculator(context);
                              },
                              onChanged: (text) {
                                debugPrint("onchange -> $text");
                                getConverterAPI(currencyCodeFrom,
                                    currencyCodeTo, conversionRate.toString());
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                String s = edtFrom.text;
                                edtFrom.text = edtTo.text;
                                edtTo.text = s;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.compare_arrows_outlined,
                              ),
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
                            child: TextFormField(
                              controller: edtFrom,
                              showCursor: false,
                              readOnly: true,
                              autofocus: false,
                              keyboardType: TextInputType.none,
                              onTap: () {
                                if (_isContainerVisible) {
                                  _isContainerVisible = false;
                                } else {
                                  _isContainerVisible = true;
                                }
                                if (_isContainerVisibleTwo) {
                                  _isContainerVisibleTwo = false;
                                }
                                setState(() {
                                  debugPrint("Hello");

                                  arrowPosition = !arrowPosition;
                                });
                                debugPrint("Hello1");

                                debugPrint("Hello2");
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.ac_unit_outlined,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                              ),
                            )),
                      ),
                      const Spacer(),
                      InkWell(
                        child: Container(
                            width: appwidth * 0.45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: edtTo,
                              showCursor: false,
                              readOnly: true,
                              autofocus: false,
                              keyboardType: TextInputType.none,
                              onTap: () {
                                if (_isContainerVisibleTwo) {
                                  _isContainerVisibleTwo = false;
                                } else {
                                  _isContainerVisible = false;
                                  _isContainerVisibleTwo = true;
                                }
                                setState(() {
                                  debugPrint("Hello");

                                  arrowPositionTwo = !arrowPositionTwo;
                                });
                                debugPrint("Hello1");

                                debugPrint("Hello2");
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.ac_unit_outlined,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  //**contanerIndex Open */

                  _isContainerVisible
                      ? CurrencyFromWidget(
                          isContainerVisible: _isContainerVisible,
                          onSelect: (String currencyCode) {
                            currencyCodeFrom = currencyCode;
                            edtFrom.text = currencyCode;
                            edtCurrency.text = currencyCode;
                            _isContainerVisible = false;
                            setState(() {});
                          },
                        )
                      : _isContainerVisibleTwo
                          ? CurrencyToWidget(
                              isContainerVisibleTwo: _isContainerVisibleTwo,
                              onSelect: (String currencyCode) {
                                currencyCodeTo = currencyCode;
                                edtTo.text = currencyCode;
                                _isContainerVisibleTwo = false;
                                setState(() {});
                              },
                            )
                          : const Text(""),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Center(
                    //***Currency Text*/
                    child: Text(conversionRate.toStringAsFixed(3)),
                  ),
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
                  ? const Positioned(
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

  Future<Map<String, dynamic>> getConverterAPI(
      String form, String to, String rate) async {
    debugPrint("input from -> $form");
    debugPrint("input to -> $to");
    String url =
        "https://www.currency.wiki/api/currency/quotes/$form/$to/784565d2-9c14-4b25-8235-06f6c5029b15";

    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData converterData =
            ConverterData.fromJson(response.toString());
        debugPrint("last data from -> ${converterData.from.entries.last}");
        debugPrint("last data to -> ${converterData.to!.entries.last}");

        double a =
            double.parse(converterData.from.entries.last.value.toString());
        double b =
            double.parse(converterData.to!.entries.last.value.toString());
        conversionRate = ((a * 100) / (b * 100)) * (double.parse(rate));

        debugPrint("conversionRate $form to $to--> $conversionRate");

        setState(() {});

        return cresult;
      } else {
        print("NOT FOUND DATA");
      }
    } catch (e) {
      print(e);
    }
    return cresult;
  }

  void showCalculator(BuildContext context) {
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
              isbool
                  ? calculateCurrency.text = equation
                  : calculateCurrency.text = result;

              getConverterAPI(
                  currencyCodeFrom, currencyCodeTo, isbool ? equation : result);

              isbool = true;
            });
          }

          Widget buildButton(
              String buttonText, double buttonHeight, Color buttonColor) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.left,
                ),
                //**Alline height */
                //This is grate
                height: MediaQuery.of(context).size.height *
                        0.1 /
                        1.5 *
                        buttonHeight +
                    2.6,

                color: buttonColor,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(
                            color: MyColors.firstthemecolorgr,
                            width: 0.6,
                            style: BorderStyle.solid)),
                    padding: const EdgeInsets.all(10.0),
                    onPressed: () => buttonPressed(buttonText),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    )),
              ),
            );
          }

          return Container(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: <Widget>[
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Table(
                          children: [
                            TableRow(children: [
                              buildButton("%", 1, MyColors.calcuColor),
                              buildButton("/", 1, MyColors.calcuColor),
                              buildButton("×", 1, MyColors.calcuColor),
                            ]),
                            TableRow(children: [
                              buildButton("1", 1, MyColors.calcuColor),
                              buildButton("2", 1, MyColors.calcuColor),
                              buildButton("3", 1, MyColors.calcuColor),
                            ]),
                            TableRow(children: [
                              buildButton("4", 1, MyColors.calcuColor),
                              buildButton("5", 1, MyColors.calcuColor),
                              buildButton("6", 1, MyColors.calcuColor),
                            ]),
                            TableRow(children: [
                              buildButton("7", 1, MyColors.calcuColor),
                              buildButton("8", 1, MyColors.calcuColor),
                              buildButton("9", 1, MyColors.calcuColor),
                            ]),
                            TableRow(children: [
                              buildButton(".", 1, MyColors.calcuColor),
                              buildButton("0", 1, MyColors.calcuColor),
                              buildButton("c", 1, MyColors.calcuColor),
                            ]),
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Table(children: [
                            TableRow(children: [
                              buildButton("⌫", 1, MyColors.calcuColor),
                            ]),
                            TableRow(children: [
                              buildButton("-", 1, MyColors.calcuColor),
                            ]),
                            TableRow(children: [
                              buildButton("+", 1, const Color(0xFFB2BBF5)),
                            ]),
                            TableRow(children: [
                              buildButton("=", 2, MyColors.calcuColor),
                            ]),
                          ]))
                    ],
                  ),
                ],
              ));
        });
  }
}
