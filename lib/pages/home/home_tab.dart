import 'dart:developer';

import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Models/converter_data.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'currency_from_widget.dart';
import 'currency_to_widget.dart';

class TapHome extends StatefulWidget {
  TapHome({Key? key}) : super(key: key);

  @override
  _TapHomeState createState() => _TapHomeState();
}

class _TapHomeState extends State<TapHome> {
  List<DataModel> countrycode = [];
  final dbHelper = DatabaseHelper.instance;
  String text = "00.0";
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
  TextEditingController edtFrom = TextEditingController(text:"USD");
  TextEditingController edtTo = TextEditingController(text:"INR");

  bool _isContainerVisible = false;
  bool _isContainerVisibleTwo = false;
  String convertedDateTime = "";
  DateTime now = DateTime.now();

  String currencyCodeFrom = "USD";
  String currencyCodeTo = "";
  Map<String, double> cresult = {};
  //String text = '';
  @override
  void initState() {
    currencyCodeFrom = "USD";


    // format(conversionRate);
    Insert();
    getCurrencyCode();

    super.initState();
  }

  getCurrencyCode() async {
    final prefs = await SharedPreferences.getInstance();
    currencyCodeFrom = prefs.getString(Constants.currencyCodeFrom) ?? "USD";
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
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: appwidth * 0.17,
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
                            onTap: () async {
                              _onShareWithEmptyOrigin(context);
                            },
                            child: const Icon(
                              Icons.share,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            height: 35.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  MyColors.colorPrimary.withOpacity(0.45),
                                  MyColors.colorPrimary,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                currencyCodeFrom,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 20) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 20)
                                          : 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            // width: 150,
                            child: AutoSizeTextField(
                              textAlignVertical: TextAlignVertical.center,
                              autocorrect: true,
                              maxLength: 30,
                              maxLines: 1,
                              maxFontSize: 18.0,
                              minFontSize: 7.0,
                              style: TextStyle(
                                color: MyColors.insideTextFieldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 18) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 18)
                                        : 18,
                              ),
                              controller: calculateCurrency,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                              showCursor: true,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 1.0, right: 1.0, bottom: 15.0),
                                  counterText: "",
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
                          padding: const EdgeInsets.only(right: 8.0),
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
                                child: Image.asset(
                                  "assets/images/right-left.png",
                                  scale: 8,
                                )),
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
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 20) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 20)
                                        : 20,
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
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 20) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 20)
                                        : 20,
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
                  const SizedBox(),
                  _isContainerVisible
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          constraints: const BoxConstraints(),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.8),
                          child: Image.asset(
                            "assets/images/tooltip.png",
                            scale: 7,
                          ),
                        )
                      : Container(),
                  _isContainerVisibleTwo
                      ? Container(
                          constraints: const BoxConstraints(),
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2),
                          child: Image.asset("assets/images/tooltip.png"),
                        )
                      : Container(),
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
                          : const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: _isContainerVisible || _isContainerVisibleTwo
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    getFormatText(text),
                                    wrapWords: true,
                                    // conversionRate.toStringAsFixed(MyColors.decimalformat
                                    //),
                                    maxLines: 1,
                                    maxFontSize: 18.0,
                                    minFontSize: 7.0,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 20) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 20)
                                                : 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AutoSizeText(
                                    edtTo.text,
                                    maxFontSize: 18.0,
                                    minFontSize: 7.0,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 20) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 20)
                                                : 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> Insert() async {
    print("Bobel");

    String url =
        "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";

    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        //ConverterData converterData = ConverterData.fromJson(response.toString());
        Map res = response.data!;
        Map<String, dynamic> quotes = res["quotes"];
        quotes.forEach((key, value) async {
          DataModel currencyData = DataModel(
              value: value.toString(),
              code: key,
              image: "",
              name: "",
              fav: 0,
              selected: 0);

          int id = await dbHelper.insert(currencyData.toMap());

          print("id->>>>>$id");
        });

          showAll();

      } else {
        print("NOT FOUND DATA");
      }
    } catch (e) {
      print(e);
    }
  }
  void showAll() async {
    List<Map<String, dynamic>> allRows = await dbHelper.queryAll();
    allRows.forEach((element) {
      debugPrint("element-->$element");
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    });
    print(countrycode);
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
        debugPrint("last data from -> ${converterData.from!.entries.last}");
        debugPrint("last data to -> ${converterData.to!.entries.last}");

        double a =
            double.parse(converterData.from!.entries.last.value.toString());
        double b =
            double.parse(converterData.to!.entries.last.value.toString());
        conversionRate = ((a * 100) / (b * 100)) * (double.parse(rate));
        text = double.parse(conversionRate.toString())
            .toStringAsFixed(MyColors.decimalformat);
        // format(conversionRate);

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

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share(
        "https://play.google.com/store/apps/details?id=com.tencent.ig");
  }

  showCalculator(BuildContext context) {
    showModalBottomSheet(
        barrierColor: Colors.transparent,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          buttonPressed(String buttonText) {
            setState(() {
              if (buttonText == "c") {
                isbool = true;
                calculateCurrency.text = "";
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

          Widget buildButton(String buttonText, double buttonHeight,
              Color buttonColor, double buttonTexth) {
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
                        side: const BorderSide(
                            //color: MyColors.colorPrimary,
                            width: 0.3,
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
                              color: Colors.white),
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
                              buildButton("%", 1, MyColors.calcuColor, 25),
                              buildButton("/", 1, MyColors.calcuColor, 25),
                              buildButton("×", 1, MyColors.calcuColor, 25),
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
                              buildButton("⌫", 1, MyColors.calcuColor, 25),
                            ]),
                            TableRow(children: [
                              buildButton("-", 1, MyColors.calcuColor, 25),
                            ]),
                            TableRow(children: [
                              buildButton("+", 1, MyColors.calcuColor, 25),
                            ]),
                            TableRow(children: [
                              Center(
                                  child: buildButton(
                                      "=", 2 * 1.02, MyColors.calcuColor, 40)),
                            ]),
                          ]))
                    ],
                  ),
                ],
              ));
        });
  }

  format(double conversionRate) {
    int i = MyColors.monetaryformat;
    int afterdecimal = MyColors.decimalformat;
    double amount =
        double.parse(conversionRate.toStringAsFixed(MyColors.decimalformat));
    CurrencyTextInputFormatter mformat = CurrencyTextInputFormatter(
      decimalDigits: afterdecimal,
      symbol: "",
    );
    if (i == 1) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(",", ",");
      log(text);
      text = text.replaceAll(".", ".");
      log(text);
    } else if (i == 2) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(".", " ");
      log(text);
      text = text.replaceAll(",", ".");
      log(text);
      text = text.replaceAll(" ", ",");

      //text = text.replaceFirstMapped(".", (match) => "1");
    } else if (i == 3) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      text = text.replaceAll(".", "=");
      log(text);
      text = text.replaceAll(",", ".");
      log(text);
      text = text.replaceAll(".", " ");
      text = text.replaceAll("=", ".");

      log(text);
    } else if (i == 4) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(",", " ");
      log(text);
      text = text.replaceAll(".", ",");
      log(text);
    }

    setState(() {});
  }

  String getFormatText(String text) {
    debugPrint("MyColors.decimalformat-->${MyColors.decimalformat}");
    int i = MyColors.monetaryformat;
    int afterdecimal = MyColors.decimalformat;
    double amount =
        double.parse(conversionRate.toStringAsFixed(MyColors.decimalformat));
    CurrencyTextInputFormatter mformat = CurrencyTextInputFormatter(
      decimalDigits: afterdecimal,
      symbol: "",
    );
    if (i == 1) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(",", ",");
      log(text);
      text = text.replaceAll(".", ".");
      log(text);
      return text;
    } else if (i == 2) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(".", " ");
      log(text);
      text = text.replaceAll(",", ".");
      log(text);
      text = text.replaceAll(" ", ",");
      return text;
      //text = text.replaceFirstMapped(".", (match) => "1");
    } else if (i == 3) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      text = text.replaceAll(".", "=");
      log(text);
      text = text.replaceAll(",", ".");
      log(text);
      text = text.replaceAll(".", " ");
      text = text.replaceAll("=", ".");

      log(text);
      return text;
    } else if (i == 4) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(",", " ");
      log(text);
      text = text.replaceAll(".", ",");
      log(text);
      return text;
    }
    return text;

    setState(() {});
  }
}
