import 'dart:async';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final bool _isDisposed = false;
  final bool _isExpanded = false;
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
          borderRadius: BorderRadius.circular(6.0),
        ),
        duration: const Duration(seconds: 0),
        height: widget.isContainerVisible
            ? MediaQuery.of(context).size.height * 0.632
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
                  SvgPicture.asset(
                    "assets/images/ic_search_24px.svg",
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: Colors.grey.shade400,
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
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w700),
                          ),
                          cursorColor: MyColors.colorPrimary,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5641,
              child: StreamBuilder<List<DataModel>>(
                  stream: streamController.stream,
                  initialData: countrycode,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DataModel model1 = snapshot.data![index];
                            // log(model1.toString());
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
                                      width: MediaQuery.of(context).size.width,
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
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                4.0, 4.0, 0.0, 4.0),
                                            child: SizedBox(
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
                                          ),
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
                                                .54,
                                            child: Text(
                                              model1.code
                                                  .toUpperCase()
                                                  .tr() /*model1.name!*/,
                                              textScaleFactor:
                                                  Constants.textScaleFactor,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              // softWrap: false,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: MyColors
                                                    .insideTextFieldColor,
                                                letterSpacing: 0.1,
                                                fontSize: 15.7,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              padding: const EdgeInsets.only(
                                                  right: 7.0, left: 0.0),
                                              constraints:
                                                  const BoxConstraints(),
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
                                                  ? SvgPicture.asset(
                                                      "assets/images/star_24px.svg",
                                                      height: 27,
                                                      width: 27,
                                                      color:
                                                          MyColors.colorPrimary,
                                                    )
                                                  : SvgPicture.asset(
                                                      "assets/images/star_border_24px.svg",
                                                      height: 27,
                                                      width: 27,
                                                      color:
                                                          Colors.grey.shade400,
                                                    ))
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
    );
  }

  updateAll(DataModel datamodel) async {
    await dbHelper.update(datamodel.toMap());
  }

  void orderedData() async {
    List<Map<String, dynamic>> orderableData = await dbHelper.order();
    for (var element in orderableData) {
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    }
    if (!streamController.isClosed) {
      streamController.sink.add(countrycode);
    }
    debugPrint(countrycode.toString());
  }

  void showAll() async {
    List<Map<String, dynamic>> allRows = await dbHelper.queryAll();
    for (var element in allRows) {
      debugPrint("element-->$element");
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    }
    if (!streamController.isClosed) {
      streamController.sink.add(countrycode);
    }
    debugPrint(countrycode.toString());
  }
}
