import 'dart:async';
import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CurrencyToWidget extends StatefulWidget {
  final Function(String currencyCode, String image, String symbol) onSelect;

  const CurrencyToWidget(
      {required this.isContainerVisibleTwo, Key? key, required this.onSelect})
      : super(key: key);
  final bool isContainerVisibleTwo;

  @override
  State<CurrencyToWidget> createState() => _CurrencyToWidgetState();
}

class _CurrencyToWidgetState extends State<CurrencyToWidget> {
  List<DataModel> countrycode = [];
  final dbHelper = DatabaseHelper.instance;
  TextEditingController countryNameControllerTwo = TextEditingController();
  StreamController<List<DataModel>> streamController = StreamController();
  bool starIndex = false;
  bool _isDisposed = false;
  Map<String, double> currencyMap = {};
  List<CurrencyData> currencyList = [];

  @override
  void initState() {
    super.initState();
    orderedData();
    // orderedData();
    // showAll();
  }

  @override
  void dispose() {
    streamController.sink.close();

    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    starIndex = true;

    super.setState(fn);
  }

  @override
  Widget build(BuildContext _) {
    // log("===>${widget._isContainerVisibleTwo}");
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          duration: const Duration(seconds: 0),
          height: widget.isContainerVisibleTwo
              ? MediaQuery.of(context).size.height - 280
              : 0.0,
          width: widget.isContainerVisibleTwo
              ? MediaQuery.of(context).size.width
              : 0.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      size: 22,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (String text) {
                              List<DataModel> searchList = [];

                              for (var element in countrycode) {
                                if (element.code
                                        .toString()
                                        .toLowerCase()
                                        .contains(text.trim().toLowerCase()) ||
                                    element.name
                                        .toString()
                                        .toLowerCase()
                                        .contains(text.trim().toLowerCase())) {
                                  searchList.add(element);
                                }
                              }
                              streamController.sink.add(searchList);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "search".tr().toString(),
                              hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            color: Colors.grey.shade500,
                            height: 0.7,
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5865,
                child: StreamBuilder<List<DataModel>>(
                    stream: streamController.stream,
                    initialData: countrycode,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              DataModel model1 = snapshot.data![index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      widget.onSelect(model1.code,
                                          model1.image!, model1.symbol!);
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 1, 10, 0),
                                        padding: const EdgeInsets.only(left: 0),
                                        decoration: BoxDecoration(
                                          color: MyColors.textColor,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: 35,
                                                height: 35,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      model1.image!,
                                                      fit: BoxFit.cover,
                                                    ))),
                                            Text(
                                              model1.code,
                                              textScaleFactor:
                                                  Constants.textScaleFactor,
                                              style: TextStyle(
                                                  color: MyColors
                                                      .insideTextFieldColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  40.0,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .45,
                                              child: Text(
                                                model1.code.toUpperCase().tr(),
                                                // model1.name!,
                                                textScaleFactor:
                                                    Constants.textScaleFactor,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: MyColors
                                                      .insideTextFieldColor,
                                                  fontSize: 15.7,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              splashRadius: 15,
                                              onPressed: () async {
                                                if (model1.fav == 0) {
                                                  model1.fav = 1;
                                                } else {
                                                  model1.fav = 0;
                                                }
                                                updateAll(model1);
                                                countrycode = [];
                                                orderedData();
                                              },
                                              icon: model1.fav == 1
                                                  ? Icon(
                                                      Icons.star_sharp,
                                                      size: 27.0,
                                                      color:
                                                          MyColors.colorPrimary,
                                                    )
                                                  : const Icon(
                                                      Icons.star_border,
                                                      size: 27.0,
                                                      color: Colors.grey,
                                                    ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                    color: Colors.grey.shade500,
                                    height: 0.7,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                  )
                                ],
                              );
                            });
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "${snapshot.error}",
                            textScaleFactor: Constants.textScaleFactor,
                          ),
                        );
                      }

                      return Center(
                        child: Text(
                          "no data",
                          textScaleFactor: Constants.textScaleFactor,
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

  void orderedData() async {
    List<Map<String, dynamic>> orderableData = await dbHelper.order();
    orderableData.forEach((element) {
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
      log("${countrycode.last}");
    });
    if (!streamController.isClosed) {
      streamController.sink.add(countrycode);
    }
  }

  updateAll(DataModel model) async {
    await dbHelper.update(model.toMap());
  }

  void showAll() async {
    List<Map<String, dynamic>> allRows = await dbHelper.queryAll();
    allRows.forEach((element) {
      debugPrint("element-->$element");
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    });
    if (!streamController.isClosed) {
      streamController.sink.add(countrycode);
    }
    print(countrycode);
  }
}
