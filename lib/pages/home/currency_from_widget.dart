import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
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
          borderRadius: BorderRadius.circular(13.0),
        ),
        duration: const Duration(seconds: 0),
        height: widget.isContainerVisible
            ? MediaQuery.of(context).size.height * 0.57
            : 0.0,
        width:
            widget.isContainerVisible ? MediaQuery.of(context).size.width : 0.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
              child: TextField(
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 22,
                    color: Colors.black,
                  ),
                  hintText: "Search",
                  hintStyle:
                      TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.48,
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
                            return InkWell(
                              onTap: () {
                                debugPrint("on tap -> ${model1.code}");
                                widget.onSelect(
                                    model1.code, model1.image!, model1.symbol!);
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 1, 10, 0),
                                  padding: const EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    // color: MyColors.textColor,
                                    color: MyColors.textColor,

                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: 40,
                                              height: 40,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Image.asset(
                                                    model1.image!,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 50,
                                            child: Text(
                                              model1.code,
                                              style: TextStyle(
                                                  color: MyColors
                                                      .insideTextFieldColor,
                                                  fontSize: MyColors.fontsmall
                                                      ? (MyColors.textSize -
                                                              18) *
                                                          (-1)
                                                      : MyColors.fontlarge
                                                          ? (MyColors.textSize +
                                                              18)
                                                          : 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width:MediaQuery.of(context).size.width*.45,


                                            child: AutoSizeText(
                                              model1.name!,
                                              minFontSize: 14,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: MyColors
                                                    .insideTextFieldColor,
                                                fontSize: MyColors.fontsmall
                                                    ? (MyColors.textSize - 16) *
                                                        (-1)
                                                    : MyColors.fontlarge
                                                        ? (MyColors.textSize +
                                                            16)
                                                        : 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
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
                                                    size: 30.0,
                                                    color:
                                                        MyColors.colorPrimary,
                                                  )
                                                : const Icon(
                                                    Icons.star_border,
                                                    size: 30.0,
                                                    color: Colors.grey,
                                                  ),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          });
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    }

                    return const Center(
                      child: Text("no data"),
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
