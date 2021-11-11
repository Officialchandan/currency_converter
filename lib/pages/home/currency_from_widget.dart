import 'dart:async';
import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyFromWidget extends StatefulWidget {
  final Function(String currencyCode, String image, String symbol) onSelect;

  const CurrencyFromWidget(
      {required this.isContainerVisible, required this.onSelect, Key? key})
      : super(key: key);
  final bool isContainerVisible;

  @override
  State<CurrencyFromWidget> createState() => _CurrencyFromWidgetState();
}

class _CurrencyFromWidgetState extends State<CurrencyFromWidget> {
  List<DataModel> countrycode = [];
  final dbHelper = DatabaseHelper.instance;
  int indexForSelectedCurrency = 0;
  final StreamController<List<DataModel>> streamController = StreamController();
  TextEditingController edtCurrencyCode = TextEditingController();
  bool starIndex = false;
  bool _isDisposed = false;
  bool _isExpanded = false;
  Map<String, double> from = {};
  Map<String, double> to = {};
  Map<String, double> currencyMap = {};

  @override
  void initState() {
    orderedData();
    if (edtCurrencyCode.text.isEmpty) {
      edtCurrencyCode.text = "";
    }
    super.initState();
  }

  @override
  void dispose() {
    streamController.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        curve: _isExpanded ? Curves.elasticOut : Curves.easeInSine,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        duration: const Duration(seconds: 0),
        height: widget.isContainerVisible
            ? MediaQuery.of(context).size.height - 280
            : 0.0,
        width:
            widget.isContainerVisible ? MediaQuery.of(context).size.width : 0.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Icon(
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
              height: MediaQuery.of(context).size.height - 350,
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
                            log(model1.toString());
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    debugPrint("on tap -> ${model1.code}");
                                    widget.onSelect(model1.code, model1.image!,
                                        model1.symbol!);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 1, 10, 0),
                                      padding: const EdgeInsets.only(left: 0),
                                      decoration: BoxDecoration(
                                        color: MyColors.textColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 40,
                                              height: 40,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                fontSize: 17,
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
                                              model1.code
                                                  .toUpperCase()
                                                  .tr() /*model1.name!*/,
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
            const SizedBox(
              height: 14.0,
            ),
          ],
        ),
      ),
    );
  }

  updateAll(DataModel datamodel) async {
    await dbHelper.update(datamodel.toMap());
  }

  void orderedData() async {
    List<Map<String, dynamic>> orderableData = await dbHelper.order();
    orderableData.forEach((element) {
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    });
    if (!streamController.isClosed) {
      streamController.sink.add(countrycode);
    }
    print(countrycode);
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
