import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:currency_converter/Models/converter_data.dart';
import 'package:currency_converter/Models/model.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/pages/home/home_tab.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Map<String, double> cresult = {};

  List<CurrencyData> selecteddata = [];

  List<CurrencyData> liveData = [];

  List<String> favList = [];

  @override
  void initState() {
    super.initState();
    getCurrencyCode();
    getcurrencySaveDataListAdd();
  }

  getCurrencyCode() async {
    // final prefs = await SharedPreferences.getInstance();
    // currencyCodeFrom = prefs.getString(Constants.currencyCodeFrom) ?? "";
    // currencyCodeTo = prefs.getString(Constants.currencyCodeFrom) ?? "";

    if (currencyCodeFrom.isNotEmpty && currencyCodeTo.isNotEmpty) {
      edtFrom.text = currencyCodeFrom;
      edtTo.text = currencyCodeTo;

      getConverterAPI(
          currencyCodeFrom, currencyCodeTo, conversionRate.toString());
    }
    setState(() {});
  }

  void getcurrencySaveDataListAdd() async {
    final prefs = await SharedPreferences.getInstance();
    favList = prefs.getStringList(Constants.currencySaveData) ?? [];
    debugPrint("$favList");
    selecteddata.clear();
    for (String element in favList) {
      CurrencyData data = CurrencyData.fromMap(element);
      selecteddata.add(data);
    }
    debugPrint("selected List $selecteddata");
    setState(() {});
  }

  void setcurrencySaveListData(List<String> selected) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(Constants.currencySaveData, selected);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    calculatorTextSize = appheight * 0.030;
    print(calculatorTextSize);
    return Scaffold(
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
        child: SingleChildScrollView(
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
                          "update:".tr().toString(),
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
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              selecteddata.isNotEmpty
                  ? SizedBox(
                      child: ReorderableListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: selecteddata.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 45.0,
                            padding: const EdgeInsets.only(right: 10, left: 5),
                            key: ValueKey(selecteddata[index].key),
                            margin: const EdgeInsets.only(top: 1.1),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: MyColors.textColor,
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: selecteddata.isNotEmpty
                                ? SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.image),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 8.0),
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
                                              selecteddata[index].key,
                                              style: TextStyle(
                                                color: MyColors.textColor,
                                                fontSize: MyColors.fontsmall
                                                    ? (MyColors.textSize - 18) *
                                                        (-1)
                                                    : MyColors.fontlarge
                                                        ? (MyColors.textSize +
                                                            18)
                                                        : 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: AutoSizeTextField(
                                            cursorColor: MyColors.colorPrimary,
                                            cursorWidth: 2.3,
                                            controller:
                                                selecteddata[index].controller,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.none,
                                            showCursor: true,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 1.0,
                                                    right: 1.0,
                                                    bottom: 1.0,
                                                    top: 1),
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
                                              getConverterAPI(
                                                  currencyCodeFrom,
                                                  currencyCodeTo,
                                                  conversionRate.toString());
                                              text = selecteddata[index]
                                                  .controller
                                                  .text;
                                              debugPrint("onchange -> $text");

                                              setState(() {});
                                            },
                                            onTap: () async {
                                              showCalculator(
                                                  context,
                                                  selecteddata[index]
                                                      .controller);

                                              setState(() {});
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
                                                  selecteddata[index]
                                                          .changeIcon =
                                                      !selecteddata[index]
                                                          .changeIcon;

                                                  selecteddata.removeAt(index);
                                                  favList.removeAt(index);

                                                  setcurrencySaveListData(
                                                      favList);
                                                  setState(() {});
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
                                  )
                                : Container(),
                          );
                        },
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex = newIndex - 1;
                            }
                            final element = selecteddata.removeAt(oldIndex);
                            selecteddata.insert(newIndex, element);
                          });
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          selecteddata = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCurrency()));
          setState(() {});
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: MyColors.colorPrimary,
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
        debugPrint("last data from -> ${converterData.from!.entries.last}");
        debugPrint("last data to -> ${converterData.to!.entries.last}");

        double a =
            double.parse(converterData.from!.entries.last.value.toString());
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

  showCalculator(BuildContext context, TextEditingController controller) {
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

              // getConverterAPI(
              //     currencyCodeFrom, currencyCodeTo, isbool ? equation : result);

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
                    const Color(0xff97aaca),
                    MyColors.colorPrimary,
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
                              buildButton("%", 1, MyColors.calcuColor,
                                  calculatorTextSize),
                              buildButton("/", 1, MyColors.calcuColor, 25),
                              buildButton("×", 1, MyColors.calcuColor,
                                  calculatorTextSize),
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
                                  child: buildButton("⌫", 1,
                                      MyColors.calcuColor, calculatorTextSize)),
                            ]),
                            TableRow(children: [
                              buildButton("-", 1, MyColors.calcuColor, 40),
                            ]),
                            TableRow(children: [
                              buildButton("+", 1, MyColors.calcuColor,
                                  calculatorTextSize),
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
}
