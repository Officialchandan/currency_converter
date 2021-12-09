import 'dart:async';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/add_currency_screen.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:currency_converter/widget/calculator.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart' hide ReorderableList;
import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter/services.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:share/share.dart';
import 'package:flutter_svg/svg.dart';

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

  bool firstTime = true;
  DataModel? selectedData;

  Future getSelectedList() async {
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

    WidgetsBinding.instance!.addPostFrameCallback((_) {});
  }

  @override
  void didUpdateWidget(MyCurrency oldWidget) {
    if (mounted) {
      debugPrint("MyCurrency-> didUpdateWidget");

      debugPrint("selectedData-> $selectedData");

      onRefresh();
    }
    super.didUpdateWidget(oldWidget);
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

  void _reorderDone(Key item) async {
    int index = _indexOfKey(item);
    debugPrint("_indexOfKey $index");
    final draggedItem = selectedList[_indexOfKey(item)];
    debugPrint("draggedItem $draggedItem");

    if (selectedList.length == index + 1) {
      draggedItem.timeStamp = DateTime.now().millisecondsSinceEpoch;
    } else {
      debugPrint("draggedItem ${selectedList[index + 1]}");
      draggedItem.timeStamp = selectedList[index + 1].timeStamp! - 1000;
    }

    await dbHelper.update(draggedItem.toMap());
    debugPrint("Reordering finished for ${draggedItem.code}");
  }

  final DraggingMode _draggingMode = DraggingMode.iOS;

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;

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
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 10),
          height: appheight,
          width: appwidth,
          child: ReorderableList(
            onReorder: _reorderCallback,
            onReorderDone: _reorderDone,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      toolbarHeight: 50,
                      title: Text(
                        "updated_date".tr().toString() +
                            " " +
                            Utility.getFormatDate(),
                        textScaleFactor: Constants.textScaleFactor,
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.textColor,
                          fontSize: 16.5,
                        ),
                      ),
                      actions: [
                        InkWell(
                          onTap: () {
                            _onShareWithEmptyOrigin(context);
                          },
                          child: Icon(
                            Icons.share,
                            color: MyColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ]),
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
                                debugPrint("firstTime$firstTime");
                                selectedList[index].controller.text = "1";
                                calculateExchangeRate(
                                    "1", 0, selectedList[index]);
                                firstTime = false;
                              }

                              return Item(
                                data: selectedList[index],
                                isFirst: index == 0,
                                isLast: index == selectedList.length - 1,
                                draggingMode: _draggingMode,
                                onItemRemove: () async {
                                  if (selectedList[index].code ==
                                      await Utility.getStringPreference(
                                          "code")) {
                                    await Utility.setStringPreference(
                                        "value", "1");
                                    await Utility.setStringPreference(
                                        "code", "");
                                  }

                                  selectedList.removeAt(index);

                                  if (selectedList.isNotEmpty) {
                                    String s = selectedList.first.value
                                        .replaceAll(RegExp(r'[^0-9]'), '');
                                    List<String> str = s.split("");
                                    if ((str.length - MyColors.decimalFormat) >
                                            0 &&
                                        MyColors.decimalFormat > 0) {
                                      str.insert(
                                          str.length - MyColors.decimalFormat,
                                          ".");
                                    }
                                    s = "";
                                    for (var element in str) {
                                      s += element;
                                    }

                                    await Utility.setStringPreference(
                                        "value", s);
                                    await Utility.setStringPreference(
                                        "code", selectedList.first.code);
                                    selectedList.first.value = s;
                                    selectedData = selectedList.first;
                                  }

                                  streamController.add(selectedList);
                                },
                                onChange: (text) {
                                  calculateExchangeRate(
                                      text, index, selectedList[index]);
                                },
                                onTap: () {
                                  isCalculatorVisible = true;

                                  debugPrint("index------->$index");
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: StreamBuilder<DataModel>(
          stream: dataController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if ((selectedData != null &&
                      selectedData!.code != snapshot.data!.code) ||
                  firstTime) {
                String s = snapshot.data!.controller.text;

                debugPrint("s--->$s");

                s = s.replaceAll(RegExp(r'[^0-9]'), '');
                List<String> str = s.split("");

                debugPrint("str--->$str");
                debugPrint("decimalFormat--->${MyColors.decimalFormat}");
                debugPrint("${str.length - MyColors.decimalFormat}");
                if ((str.length - MyColors.decimalFormat) > 0 &&
                    MyColors.decimalFormat > 0) {
                  str.insert(str.length - MyColors.decimalFormat, ".");
                }
                s = "";

                for (var element in str) {
                  s += element;
                }
                snapshot.data!.controller.text = s;
                snapshot.data!.controller.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: snapshot.data!.controller.value.text.length);

                int i = selectedList.indexWhere(
                    (element) => element.code == snapshot.data!.code);
                if (i != -1) {
                  calculateExchangeRate(
                      snapshot.data!.controller.text, i, snapshot.data!);
                }
              }

              selectedData = snapshot.data;

              return Calculator(
                txtController: snapshot.data!.controller,
                onChange: (text) async {
                  await Utility.setStringPreference("value", text);
                  await Utility.setStringPreference(
                      "code", snapshot.data!.code);
                  Constants.selectedEditableCurrencyCode = snapshot.data!.code;
                  Constants.selectedEditableCurrencyValue = text;

                  int i = selectedList.indexWhere(
                      (element) => element.code == snapshot.data!.code);
                  if (i != -1) {
                    calculateExchangeRate(text, i, snapshot.data!);
                  }
                },
              );
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
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddCurrency()));

            selectedList.clear();
            selectedList = await dbHelper.getSelectedData();
            debugPrint("selectedList-->$selectedList");

            FocusScope.of(context).unfocus();
            String value = await Utility.getStringPreference("value");
            String code = await Utility.getStringPreference("code");
            debugPrint("value-->$value");
            debugPrint("code-->$code");
            dataController.addError("error");
            if (value.isNotEmpty && code.isNotEmpty) {
              int index =
                  selectedList.indexWhere((element) => element.code == code);
              if (index != -1) {
                selectedList[index].controller.text = value;
                calculateExchangeRate(selectedList[index].controller.text,
                    index, selectedList[index]);
              }
            } else {
              debugPrint("savedvalueisnothere");
              firstTime = true;
            }

            streamController.add(selectedList);
          },
          child: SvgPicture.asset("assets/images/plus-icon.svg",
              color: MyColors.colorPrimary),
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
          double conversionRate = ((double.parse(model.value) * 100) /
                  (double.parse(element.value) * 100)) *
              (d);

          debugPrint("conversionRate->$conversionRate");
          String m = getFormatText(
              conversionRate.toStringAsFixed(MyColors.decimalFormat));
          element.controller.text = m;
          element.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: element.controller.text.length));
          element.exchangeValue = m;
        }
      }

      streamController.add(selectedList);
    } catch (e) {}
  }

  String getFormatText(String s) {
    String text1 = "";

    int i = MyColors.monetaryFormat;
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

      text1 = text1.replaceAll(".", " ");

      text1 = text1.replaceAll(",", ".");

      text1 = text1.replaceAll(" ", ",");
      return text1;
      //text = text.replaceFirstMapped(".", (match) => "1");
    } else if (i == 3) {
      text1 = mformat.format(s.replaceAll(".", ""));
      text1 = text1.replaceAll(".", "=");

      text1 = text1.replaceAll(",", ".");

      text1 = text1.replaceAll(".", " ");
      text1 = text1.replaceAll("=", ".");

      return text1;
    } else if (i == 4) {
      text1 = mformat.format(s.replaceAll(".", ""));

      text1 = text1.replaceAll(",", " ");

      text1 = text1.replaceAll(".", ",");

      return text1;
    }
    return text1;
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share(
        "https://play.google.com/store/apps/details?id=com.tencent.ig");
  }

  void onRefresh() async {
    FocusScope.of(context).unfocus();
    String value = await Utility.getStringPreference("value");
    String code = await Utility.getStringPreference("code");
    dataController.addError("error");
    if (value.isNotEmpty && code.isNotEmpty) {
      int index = selectedList.indexWhere((element) => element.code == code);
      if (index != -1) {
        selectedList[index].controller.text = value;
        calculateExchangeRate(
            selectedList[index].controller.text, index, selectedList[index]);
      }
    }
    if (mounted) {
      setState(() {});
    }
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
  bool isbool = true;

  final dbHelper = DatabaseHelper.instance;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
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
                    ? DelayedReorderableListener(
                        delay: Duration(seconds: 1),
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
                    : Text(
                        "",
                        textScaleFactor: Constants.textScaleFactor,
                      ),

                MyColors.displaycode
                    ? DelayedReorderableListener(
                        delay: Duration(seconds: 1),
                        child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          height: 35.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Container(
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
                                textScaleFactor: Constants.textScaleFactor,
                                style: TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : //Currency Code
                    MyColors.displayflag
                        ? DelayedReorderableListener(
                            delay: Duration(seconds: 1),
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
                        DelayedReorderableListener(
                            delay: Duration(seconds: 1),
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
                                  textScaleFactor: Constants.textScaleFactor,
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                    fontSize: 18,
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
                    ? DelayedReorderableListener(
                        delay: Duration(seconds: 1),
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
                              textScaleFactor: Constants.textScaleFactor,
                              style: TextStyle(
                                color: MyColors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text(
                        "",
                        textScaleFactor: Constants.textScaleFactor,
                      ),

                Expanded(
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: Constants.textScaleFactor,
                    ),
                    child: DelayedReorderableListener(
                      delay: const Duration(milliseconds: 400),
                      canStart: () {
                        return true;
                      },
                      key: key,
                      child: AutoSizeTextField(
                        controller: data.controller,
                        cursorColor: MyColors.colorPrimary,
                        textAlignVertical: TextAlignVertical.center,
                        autocorrect: true,
                        maxLength: 30,
                        maxLines: 1,
                        maxFontSize: 17.0,
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
                        onChanged: (String text) async {
                          if (text.isEmpty) {
                            text = "0";
                          }
                          text = text.replaceAll(RegExp(r'[^0-9]'), '');
                          await Utility.setStringPreference("value", text);
                          await Utility.setStringPreference("code", data.code);
                          Constants.selectedEditableCurrencyCode = data.code;
                          Constants.selectedEditableCurrencyValue = text;
                          data.controller.text = text;
                          // text = data.controller.text;
                          data.controller.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: data.controller.text.length));
                          onChange(text);
                          // calculateExchangeRate(text);
                        },
                        onTap: () async {
                          data.controller.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: data.controller.text.length));
                          // isCalculatorVisible = true;
                          // dataController.add(data);

                          onTap();
                        },
                      ),
                    ),
                  ),
                ),
                DelayedReorderableListener(
                  delay: Duration(seconds: 1),
                  child: Container(
                    width: 50,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/arrows-vertical.svg",
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        InkWell(
                          onTap: () {
                            data.selected = 0;
                            data.timeStamp = 0;
                            dbHelper.update(data.toMap());
                            onItemRemove();
                          },
                          child: SvgPicture.asset(
                            "assets/images/close-red.svg",
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
