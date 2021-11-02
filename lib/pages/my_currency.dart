import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/add_currency_screen.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:currency_converter/widget/calculator.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart' hide ReorderableList;
import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter/services.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:share/share.dart';

class MyCurrency extends StatefulWidget {
  MyCurrency({Key? key}) : super(key: key);

  @override
  _MyCurrencyState createState() => _MyCurrencyState();
}

enum DraggingMode {
  iOS,
  android,
}

class _MyCurrencyState extends State<MyCurrency> {
  final DateTime now = DateTime.now();

  List<DataModel> selectedList = [];
  final dbHelper = DatabaseHelper.instance;
  StreamController<List<DataModel>> streamController = StreamController();
  StreamController<DataModel> dataController = StreamController();
  bool isCalculatorVisible = false;
  var calculatorTextSize;
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  bool isbool = true;

  bool firstTime = true;

  void getSelectedList() async {
    firstTime = true;
    selectedList.clear();
    selectedList = await dbHelper.getSelectedData();
    debugPrint("selectedList-->$selectedList");
    streamController.add(selectedList);
  }

  // Returns index of item with given key
  int _indexOfKey(Key key) {
    return selectedList.indexWhere((DataModel d) => d.key == key);
  }

  @override
  void initState() {
    getSelectedList();
    super.initState();
  }

  @override
  void didUpdateWidget(MyCurrency oldWidget) {
    debugPrint("MyCurrency-> didUpdateWidget");
    dataController.addError("error");
    streamController.add(selectedList);

    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    // Uncomment to allow only even target reorder possition
    // if (newPositionIndex % 2 == 1)
    //   return false;

    final draggedItem = selectedList[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      selectedList.removeAt(draggingIndex);
      selectedList.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem = selectedList[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.code}}");
  }

  //
  // Reordering works by having ReorderableList widget in hierarchy
  // containing ReorderableItems widgets
  //

  DraggingMode _draggingMode = DraggingMode.iOS;

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    calculatorTextSize = appheight * 0.050;
    return WillPopScope(
      onWillPop: () async {
        if (isCalculatorVisible) {
          isCalculatorVisible = false;
          dataController.addError("error");
        } else {
          SystemNavigator.pop();
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
              MyColors.colorPrimary.withOpacity(1.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: ReorderableList(
            onReorder: this._reorderCallback,
            onReorderDone: this._reorderDone,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  actions: <Widget>[
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
                  pinned: false,
                  centerTitle: true,
                  expandedHeight: 50.0,
                  backgroundColor: Colors.transparent,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
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
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        Utility.getFormatDate(),
                        style: TextStyle(
                          color: MyColors.textColor,
                          fontSize: MyColors.fontsmall
                              ? (MyColors.textSize - 18) * (-1)
                              : MyColors.fontlarge
                                  ? (MyColors.textSize + 18)
                                  : 18,
                        ),
                      ),
                      // MyColors.datemm
                      //     ? Text(
                      //         "${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year.toString()}",
                      //         style: TextStyle(
                      //           color: MyColors.textColor,
                      //           fontSize: MyColors.fontsmall
                      //               ? (MyColors.textSize - 18) * (-1)
                      //               : MyColors.fontlarge
                      //                   ? (MyColors.textSize + 18)
                      //                   : 18,
                      //         ),
                      //       )
                      //     : Text(
                      //         "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}",
                      //         style: TextStyle(
                      //           color: MyColors.textColor,
                      //           fontSize: MyColors.fontsmall
                      //               ? (MyColors.textSize - 18) * (-1)
                      //               : MyColors.fontlarge
                      //                   ? (MyColors.textSize + 18)
                      //                   : 18,
                      //         ),
                      //       ),
                    ],
                  ),
                ),
                StreamBuilder(
                  builder: (context, snapshot) {
                    return SliverPadding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index == 0 && firstTime) {
                                selectedList[index].controller.text = "1";
                                calculateExchangeRate("1", 0, selectedList[index]);
                                firstTime = false;
                              }
                              // selectedList[index].controller.text = getFormatText(
                              //     double.parse(selectedList[index].controller.text.replaceAll(",", "").replaceAll("-", ""))
                              //         .toStringAsFixed(MyColors.decimalFormat));
                              return Item(
                                data: selectedList[index],
                                // first and last attributes affect border drawn during dragging
                                isFirst: index == 0,
                                isLast: index == selectedList.length - 1,
                                draggingMode: _draggingMode,
                                onItemRemove: () {
                                  selectedList.removeAt(index);
                                  streamController.add(selectedList);
                                },
                                onChange: (text) {
                                  calculateExchangeRate(text, index, selectedList[index]);
                                },
                                onTap: () {
                                  isCalculatorVisible = true;
                                  dataController.add(selectedList[index]);
                                },
                              );
                            },
                            childCount: selectedList.length,
                          ),
                        ));
                  },
                  stream: streamController.stream,
                ),
                // SliverPadding(
                //     padding: EdgeInsets.only(
                //         bottom: MediaQuery.of(context).padding.bottom,
                //     ),
                //     sliver: SliverList(
                //       delegate: SliverChildBuilderDelegate(
                //         (BuildContext context, int index) {
                //           return Item(
                //             data: selectedList[index],
                //             // first and last attributes affect border drawn during dragging
                //             isFirst: index == 0,
                //             isLast: index == selectedList.length - 1,
                //             draggingMode: _draggingMode,
                //           );
                //         },
                //         childCount: selectedList.length,
                //       ),
                //     )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: StreamBuilder<DataModel>(
          stream: dataController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Calculator(
                txtController: snapshot.data!.controller,
                onChange: (text) {
                  int i = selectedList.indexWhere((element) => element.code == snapshot.data!.code);
                  if (i != -1) {
                    calculateExchangeRate(text, i, snapshot.data!);
                  }
                },
              );

              return calculator(context, snapshot.data!.controller, (changeValue) {
                int i = selectedList.indexWhere((element) => element.code == snapshot.data!.code);
                if (i != -1) {
                  calculateExchangeRate(changeValue, i, snapshot.data!);
                }
              });
            }
            return const SizedBox(
              width: 0,
              height: 0,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.textColor,
          onPressed: () async {
            streamController.add([]);
            await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCurrency()));
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

  void calculateExchangeRate(String text, int index, DataModel model) async {
    try {
      debugPrint("onchange$text");
      double d = double.parse(text);
      debugPrint("d$d");
      for (DataModel element in selectedList) {
        if (element.code != model.code) {
          double conversionRate = ((double.parse(model.value) * 100) / (double.parse(element.value) * 100)) * (d);

          debugPrint("conversionRate->$conversionRate");
          String m = await getFormatText(conversionRate.toStringAsFixed(MyColors.decimalFormat));

          element.controller.text = m;
          element.controller.selection = TextSelection.fromPosition(TextPosition(offset: element.controller.text.length));
          element.exchangeValue = m;
        }
      }

      streamController.add(selectedList);
    } catch (e) {}
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

  Widget calculator(BuildContext context, TextEditingController controller, Function(String changeValue) onChange) {
    buttonPressed(String buttonText) {
      setState(() {
        if (buttonText == "c") {
          isbool = true;
          equation = "0";
          expression = "";
          isbool = false;
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } else if (buttonText == "⌫") {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation.substring(0, equation.length - 1);

          if (equation == "") {
            equation = "0";
            expression = "";
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
            result = getFormatText(double.parse(result).toStringAsFixed(MyColors.decimalFormat));

            expression = "$result";
            equation = "$result";
          } catch (e) {
            result = "";
          }
        } else {
          debugPrint("isbool-->$isbool");
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if (equation == "0") {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }

        isbool ? controller.text = equation : controller.text = result;

        controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

        isbool ? onChange(equation) : onChange(result);

        isbool = true;
      });
    }

    buildButton(String buttonText, double buttonHeight, Color buttonColor, double buttonTexth) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.left,
          ),
          height: MediaQuery.of(context).size.height * 0.1 / 1.5 * buttonHeight + 2.6,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              MyColors.colorPrimary.withOpacity(.5),
              // Colors.white.withOpacity(.2),
              MyColors.colorPrimary.withOpacity(.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            //stops: [0.0,0.0]
          )),
          child: MaterialButton(
              onLongPress: () {
                if (buttonText == "⌫") {
                  equation = "0";
                  expression = "";
                  controller.clear();
                  controller.text = "0";
                  controller.selection = TextSelection.fromPosition(TextPosition(offset: 1));
                }
                // buttonPressed(buttonText);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(color: MyColors.colorPrimary, width: 0.4, style: BorderStyle.solid)),
              padding: const EdgeInsets.all(0.0),
              onPressed: () => buttonPressed(buttonText),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: buttonTexth, fontWeight: FontWeight.normal, color: MyColors.textColor),
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
                        buildButton("%", 1, MyColors.calcuColor, 20),
                        buildButton("/", 1, MyColors.calcuColor, 20),
                        buildButton("×", 1, MyColors.calcuColor, 27),
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
                        buildButton("⌫", 1, MyColors.calcuColor, 20),
                      ]),
                      TableRow(children: [
                        buildButton("-", 1, MyColors.calcuColor, 35),
                      ]),
                      TableRow(children: [
                        buildButton("+", 1, MyColors.calcuColor, 25),
                      ]),
                      TableRow(children: [
                        Center(child: buildButton("=", 2 * 1.02, MyColors.calcuColor, 40)),
                      ]),
                    ]))
              ],
            ),
          ],
        ));
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share("https://play.google.com/store/apps/details?id=com.tencent.ig");
  }
}

class Item extends StatelessWidget {
  Item({
    required this.data,
    required this.isFirst,
    required this.isLast,
    required this.draggingMode,
    required this.onItemRemove,
    required this.onChange,
    required this.onTap,
  });

  final DataModel data;
  final bool isFirst;
  final bool isLast;
  final DraggingMode draggingMode;
  final Function onItemRemove;
  final Function(String text) onChange;
  final Function onTap;

  final dbHelper = DatabaseHelper.instance;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy || state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(
        color: MyColors.textColor,
        borderRadius: BorderRadius.circular(7.0),
      );
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
        color: MyColors.textColor,
        borderRadius: BorderRadius.circular(7.0),
      );
    }

    // For iOS dragging mode, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = draggingMode == DraggingMode.iOS
        ? IntrinsicHeight(
            child: Row(
              children: [
                MyColors.displayflag && MyColors.displaycode
                    ? ReorderableListener(
                        canStart: () {
                          return false;
                        },
                        child: Container(
                            width: 40,
                            height: 40,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  data.image!,
                                  fit: BoxFit.cover,
                                ))),
                      )
                    : Text(""),

                MyColors.displaycode
                    ? ReorderableListener(
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
                            child: Text(
                              data.code,
                              style: TextStyle(
                                color: MyColors.textColor,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 18) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 18)
                                        : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : //Currency Code
                    MyColors.displayflag
                        ? ReorderableListener(
                            child: SizedBox(
                                width: 40,
                                height: 40,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      data.image!,
                                      fit: BoxFit.cover,
                                    ))),
                          )
                        : //flag
                        ReorderableListener(
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
                                child: Text(
                                  data.symbol!,
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                    fontSize: MyColors.fontsmall
                                        ? (MyColors.textSize - 18) * (-1)
                                        : MyColors.fontlarge
                                            ? (MyColors.textSize + 18)
                                            : 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ), //symbol
                const SizedBox(
                  width: 5,
                ),
                MyColors.displayflag && MyColors.displaysymbol
                    ? ReorderableListener(
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
                            child: Text(
                              data.symbol!,
                              style: TextStyle(
                                color: MyColors.textColor,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 18) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 18)
                                        : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text(""),

                Expanded(
                  child: AutoSizeTextField(
                    cursorColor: MyColors.colorPrimary,
                    cursorWidth: 2.3,
                    controller: data.controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.none,
                    showCursor: true,
                    readOnly: false,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 1.0, right: 1.0, top: 1.0, bottom: 1.0),
                        counterText: "",
                        border: InputBorder.none),
                    style: TextStyle(
                      color: MyColors.colorPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: MyColors.fontsmall
                          ? (MyColors.textSize - 18) * (-1)
                          : MyColors.fontlarge
                              ? (MyColors.textSize + 18)
                              : 18,
                    ),
                    onChanged: (String text) {
                      data.controller.text = text;
                      // text = data.controller.text;
                      data.controller.selection = TextSelection.fromPosition(TextPosition(offset: data.controller.text.length));
                      onChange(text);
                      // calculateExchangeRate(text);
                    },
                    onTap: () async {
                      data.controller.selection = TextSelection.fromPosition(TextPosition(offset: data.controller.text.length));
                      // isCalculatorVisible = true;
                      // dataController.add(data);

                      onTap();
                    },
                  ),
                ),
                ReorderableListener(
                  child: Container(
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
                            data.selected = 0;
                            dbHelper.update(data.toMap());
                            onItemRemove();
                          },
                          child: Image.asset(
                            "assets/images/cross.png",
                            scale: 9,
                            color: MyColors.colorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();

    Widget content = Container(
      decoration: decoration,
      height: 45.0,
      padding: const EdgeInsets.only(right: 10, left: 5),
      margin: const EdgeInsets.only(top: 1.1),
      child: SafeArea(top: false, bottom: false, child: dragHandle),
    );

    // For android dragging mode, wrap the entire content in DelayedReorderableListener
    if (draggingMode == DraggingMode.android) {
      content = DelayedReorderableListener(
        child: content,
      );
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: data.key!, //
        childBuilder: _buildChild);
  }
}
