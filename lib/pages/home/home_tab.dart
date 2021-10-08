import 'package:currency_converter/Models/converter_data.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String currencyCodeFrom = "";
  String currencyCodeTo = "";
  Map<String, double> cresult = {};

  @override
  void initState() {
    getCurrencyCode();

    super.initState();
  }

  getCurrencyCode() async {
    final prefs = await SharedPreferences.getInstance();
    currencyCodeFrom = prefs.getString(Constants.currencyCodeFrom) ?? "";
    currencyCodeTo = prefs.getString(Constants.currencyCodeFrom) ?? "";

    if (currencyCodeFrom.isNotEmpty && currencyCodeTo.isNotEmpty) {
      edtFrom.text = currencyCodeFrom;
      edtTo.text = currencyCodeTo;

      getConverterAPI(
          currencyCodeFrom, currencyCodeTo, conversionRate.toString());
    }
    setState(() {});
  }

  void currencyCodeFromSave(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.currencyCodeFrom, code);
  }

  void currencyCodeToSave(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.currencyCodeTo, code);
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                            // width: appwidth * 0.05,
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
                                  MyColors.colorPrimary,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Text(
                                currencyCodeFrom,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 14) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 14)
                                          : 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height * 0.24,
                            child: TextField(
                              style: TextStyle(
                                color: MyColors.insideTextFieldColor,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 14) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 14)
                                        : 14,
                              ),
                              controller: calculateCurrency,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                              showCursor: true,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              onTap: () {
                                _isContainerVisible = false;

                                _isContainerVisibleTwo = false;
                                showCalculator(context);
                                setState(() {});
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
                                String temp = "";
                                temp = currencyCodeFrom;
                                currencyCodeFrom = currencyCodeTo;
                                currencyCodeTo = temp;

                                edtFrom.text = currencyCodeFrom;
                                edtTo.text = currencyCodeTo;

                                currencyCodeFromSave(currencyCodeFrom);
                                currencyCodeToSave(currencyCodeTo);
                                setState(() {});

                                getConverterAPI(currencyCodeFrom,
                                    currencyCodeTo, calculateCurrency.text);
                              },
                              child: Icon(
                                Icons.compare_arrows_outlined,
                                color: MyColors.insideTextFieldColor,
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
                              color: MyColors.textColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: MyColors.insideTextFieldColor,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 18) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 18)
                                        : 18,
                              ),
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
                                //*d

                                setState(() {
                                  arrowPosition = !arrowPosition;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.ac_unit_outlined,
                                  color: MyColors.insideTextFieldColor,
                                  size: 25.0,
                                ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: MyColors.insideTextFieldColor,
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
                              color: MyColors.textColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              style: TextStyle(
                                color: MyColors.insideTextFieldColor,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 16) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 16)
                                        : 16,
                              ),
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.ac_unit_outlined,
                                  color: MyColors.insideTextFieldColor,
                                  size: 25.0,
                                ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: MyColors.insideTextFieldColor,
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

                            currencyCodeFromSave(currencyCodeFrom);
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
                                currencyCodeToSave(currencyCodeTo);
                                edtTo.text = currencyCode;
                                _isContainerVisibleTwo = false;
                                setState(() {});
                              },
                            )
                          : const Text(""),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          conversionRate
                              .toStringAsFixed(MyColors.decimalformat),
                          style: TextStyle(
                              color: MyColors.textColor,
                              fontSize: MyColors.fontsmall
                                  ? (MyColors.textSize - 25) * (-1)
                                  : MyColors.fontlarge
                                      ? (MyColors.textSize + 25)
                                      : 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          edtTo.text,
                          style: TextStyle(
                              color: MyColors.textColor,
                              fontSize: MyColors.fontsmall
                                  ? (MyColors.textSize - 25) * (-1)
                                  : MyColors.fontlarge
                                      ? (MyColors.textSize + 25)
                                      : 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _isContainerVisible
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 00.232,
                      child: const Icon(
                        Icons.arrow_drop_up,
                        size: 50,
                        color: Colors.white,
                      ))
                  : Container(),
              _isContainerVisibleTwo
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 00.232,
                      left: MediaQuery.of(context).size.width * 00.480,
                      child: const Icon(
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

  showCalculator(BuildContext context) {
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
                            color: MyColors.colorPrimary,
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
                              buildButton("+", 1, MyColors.calcuColor),
                            ]),
                            TableRow(children: [
                              Center(
                                  child:
                                      buildButton("=", 2, MyColors.calcuColor)),
                            ]),
                          ]))
                    ],
                  ),
                ],
              ));
        });
  }
}
