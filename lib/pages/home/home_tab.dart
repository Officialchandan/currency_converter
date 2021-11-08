import 'dart:developer';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:currency_converter/widget/calculator.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'currency_from_widget.dart';
import 'currency_to_widget.dart';
import 'home_page.dart';

class TapHome extends StatefulWidget {
  final Function(TabChangeListener tabChangeListener) onInitialize;

  const TapHome({required this.onInitialize, Key? key}) : super(key: key);

  @override
  _TapHomeState createState() => _TapHomeState();
}

class _TapHomeState extends State<TapHome> implements TabChangeListener {
  String symbol2 = "€";

  String symbol = "\$";

  String flagfrom = "assets/pngCountryImages/USD.png";
  String flagto = "assets/pngCountryImages/EUR.png";

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
  bool isCalculatorVisible = false;
  bool _isContainerVisible = false;
  bool _isContainerVisibleTwo = false;

  TextEditingController calculateCurrency = TextEditingController(text: "0");
  TextEditingController edtFrom = TextEditingController(text: "USD");
  TextEditingController edtTo = TextEditingController(text: "EUR");

  String convertedDateTime = "";
  DateTime now = DateTime.now();

  String currencyCodeFrom = "USD";
  String currencyCodeTo = "INR";
  Map<String, double> cresult = {};

  @override
  void initState() {
    widget.onInitialize(this);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
      statusBarColor: MyColors.colorPrimary, // status bar color
    ));

    _isContainerVisible = false;
    _isContainerVisibleTwo = false;
    // Insert();
    getCurrencyCode();

    super.initState();
    setState(() {});
  }

  @override
  void onTabChange() async {
    debugPrint("onTabChange");
    isCalculatorVisible = false;
    _isContainerVisible = false;
    _isContainerVisibleTwo = false;
    text = Utility.getFormatText(await getConverterAPI(
        currencyCodeFrom, currencyCodeTo, calculateCurrency.text));

    if (mounted) {
      setState(() {});
    }
  }

  // @override
  // void didUpdateWidget(TapHome oldWidget) {
  //   debugPrint("home_tab-> didUpdateWidget");
  //   isCalculatorVisible = false;

  //   // _isContainerVisible = false;
  //   // _isContainerVisibleTwo = false;
  //   super.didUpdateWidget(oldWidget);
  //   setState(() {});
  // }

  getCurrencyCode() async {
    final prefs = await SharedPreferences.getInstance();
    currencyCodeFrom = prefs.getString(Constants.currencyCodeFrom) ?? "USD";
    currencyCodeTo = prefs.getString(Constants.currencyCodeTo) ?? "EUR";

    if (currencyCodeFrom.isNotEmpty && currencyCodeTo.isNotEmpty) {
      edtFrom.text = currencyCodeFrom;
      edtTo.text = currencyCodeTo;
      flagfrom = "assets/pngCountryImages/$currencyCodeFrom.png";
      flagto = "assets/pngCountryImages/$currencyCodeTo.png";

      symbol = await Utility.getSymbolFromPreference("hello");
      symbol2 = await Utility.getSymboltoPreference("to");

      getConverterAPI(currencyCodeFrom, currencyCodeTo, calculateCurrency.text);
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
  void dispose() {
    calculateCurrency.clear();
    calculateCurrency.text = "0";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          if (_isContainerVisible ||
              _isContainerVisibleTwo ||
              isCalculatorVisible) {
            Future.value(_isContainerVisible = false);
            Future.value(_isContainerVisibleTwo = false);
            Future.value(isCalculatorVisible = false);
            Future.value(_isContainerVisible = false);
            Future.value(_isContainerVisibleTwo = false);

            setState(() {});
          } else {
            SystemNavigator.pop();
          }
          throw true;
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
                MyColors.colorPrimary.withOpacity(1.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
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
                                textScaleFactor: Constants.textScaleFactor,
                                style: TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Text(
                                Utility.getFormatDate(),
                                textScaleFactor: Constants.textScaleFactor,
                                style: TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: 18,
                                ),
                              ),
                            )
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
                            height: 35.0,
                            width: 60.0,
                            margin: const EdgeInsets.only(left: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  colors: [
                                    MyColors.colorPrimary.withOpacity(0.4),
                                    MyColors.colorPrimary,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: MyColors.displaycode
                                  ? Center(
                                      child: AutoSizeText(
                                        currencyCodeFrom,
                                        style: TextStyle(
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  : MyColors.displaysymbol
                                      ? Center(
                                          child: Text(
                                            symbol,
                                            textScaleFactor:
                                                Constants.textScaleFactor,
                                            style: TextStyle(
                                              color: MyColors.textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: AutoSizeText(
                                            currencyCodeFrom,
                                            style: TextStyle(
                                              color: MyColors.textColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
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
                              controller: calculateCurrency,
                              textAlignVertical: TextAlignVertical.center,
                              autocorrect: true,
                              maxLength: 30,
                              maxLines: 1,
                              maxFontSize: 18.0,
                              minFontSize: 7.0,
                              style: TextStyle(
                                color: MyColors.colorPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                              showCursor: true,
                              readOnly: false,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 1.0, right: 1.0, bottom: 15.0),
                                  counterText: "",
                                  border: InputBorder.none),
                              onTap: () {
                                isCalculatorVisible = true;
                                _isContainerVisible = false;
                                _isContainerVisibleTwo = false;

                                setState(() {});
                              },
                              onChanged: (text) {
                                print("onchange---------> $text");
                                getConverterAPI(
                                    currencyCodeFrom, currencyCodeTo, text);
                                calculateCurrency.text = text;
                                calculateCurrency.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: calculateCurrency.text.length));
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

                                  String temp3 = "";
                                  temp3 = symbol;
                                  symbol = symbol2;
                                  symbol2 = temp3;

                                  String temp1 = "";
                                  temp1 = flagfrom;
                                  flagfrom = flagto;
                                  flagto = temp1;

                                  currencyCodeFromSave(currencyCodeFrom);
                                  currencyCodeToSave(currencyCodeTo);
                                  setState(() {});

                                  getConverterAPI(currencyCodeFrom,
                                      currencyCodeTo, calculateCurrency.text);
                                  calculateCurrency.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              calculateCurrency.text.length));
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
                                fontSize: 18,
                              ),
                              controller: edtFrom,
                              showCursor: false,
                              readOnly: true,
                              autofocus: false,
                              // keyboardType: TextInputType.none,
                              onTap: () {
                                if (_isContainerVisible) {
                                  _isContainerVisible = false;
                                } else {
                                  isCalculatorVisible = false;
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
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 10,
                                  width: 10,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      flagfrom,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: MyColors.insideTextFieldColor,
                                    size: 23.0,
                                  ),
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
                                fontSize: 18,
                              ),
                              controller: edtTo,
                              showCursor: false,
                              readOnly: true,
                              autofocus: false,
                              // keyboardType: TextInputType.none,
                              onTap: () {
                                if (_isContainerVisibleTwo) {
                                  _isContainerVisibleTwo = false;
                                } else {
                                  _isContainerVisible = false;
                                  isCalculatorVisible = false;
                                  _isContainerVisibleTwo = true;
                                }
                                setState(() {
                                  arrowPositionTwo = !arrowPositionTwo;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Container(
                                  padding: EdgeInsets.all(5),
                                  width: 15,
                                  height: 15,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      flagto,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: MyColors.insideTextFieldColor,
                                    size: 23.0,
                                  ),
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
                          onSelect: (String currencyCode, String image,
                              String symbol1) {
                            symbol = symbol1;
                            currencyCodeFrom = currencyCode;
                            flagfrom = image;
                            Utility.setSymbolFromPreference("hello", symbol);

                            currencyCodeFromSave(currencyCodeFrom);
                            edtFrom.text = currencyCode;

                            _isContainerVisible = false;
                            getConverterAPI(currencyCodeFrom, currencyCodeTo,
                                calculateCurrency.text);
                            calculateCurrency.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: calculateCurrency.text.length));

                            setState(() {});
                          },
                        )
                      : _isContainerVisibleTwo
                          ? CurrencyToWidget(
                              isContainerVisibleTwo: _isContainerVisibleTwo,
                              onSelect: (String currencyCode, String image,
                                  String symbol) {
                                symbol2 = symbol;
                                flagto = image;
                                Utility.setSymbolFromPreference("to", symbol2);

                                currencyCodeTo = currencyCode;
                                currencyCodeToSave(currencyCodeTo);
                                edtTo.text = currencyCode;
                                _isContainerVisibleTwo = false;
                                getConverterAPI(currencyCodeFrom,
                                    currencyCodeTo, calculateCurrency.text);
                                calculateCurrency.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: calculateCurrency.text.length));
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
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        minWidth: 50),
                                    child: AutoSizeText(
                                      Utility.getFormatText(text),
                                      wrapWords: true,
                                      maxLines: 1,
                                      maxFontSize: 32.0,
                                      minFontSize: 15.0,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400),
                                    ),
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
              height: isCalculatorVisible
                  ? MediaQuery.of(context).size.height * 0.32000
                  : 0.0,
              width:
                  isCalculatorVisible ? MediaQuery.of(context).size.width : 0.0,
              // child: calculator(),
              child: isCalculatorVisible
                  ? Calculator(
                      txtController: calculateCurrency,
                      onChange: (text) async {
                        this.text = await getConverterAPI(
                            currencyCodeFrom, currencyCodeTo, text);
                        setState(() {});
                      },
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    )),
        ));
  }

  Future<void> Insert() async {
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

          //
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
      // debugPrint("element-->$element");
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    });
  }

  void particularrow() async {}

  Future<String> getConverterAPI(String form, String to, String rate) async {
    List<Map<String, dynamic>> formRow = await dbHelper.particular_row(form);
    List<Map<String, dynamic>> toRow = await dbHelper.particular_row(to);

    try {
      double a = double.parse(formRow.first.values.toList()[3]);
      double b = double.parse(toRow.first.values.toList()[3]);
      conversionRate = ((a * 100) / (b * 100)) * (double.parse(rate));
      text = conversionRate.toStringAsFixed(MyColors.decimalFormat);
      setState(() {});
      return Utility.getFormatText(text);
    } catch (e) {
      print(e);
    }
    return text;
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share(
        "https://play.google.com/store/apps/details?id=com.tencent.ig");
  }

  String getFormatText(String s) {
    getConverterAPI(currencyCodeFrom, currencyCodeTo, s);
    String text1 = text;
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
}
