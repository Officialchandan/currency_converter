import 'dart:async';
import 'dart:developer';

import 'package:currency_converter/API/apis.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/home/home_page.dart';

import 'package:flutter/material.dart';

class CurrencyToWidget extends StatefulWidget {
  final Function(String currencyCode) onSelect;

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
    showAll();
   // orderedData();
   // showAll();
  }

  Future getData() async {
    currencyMap = await Apiclass.getUser();

    currencyMap.forEach((key, value) {
      currencyList.add(CurrencyData(
        key: key.toString(),
        value: value,
      ));
    });

    if (!streamController.isClosed) {
      // streamController.sink.add(currencyList);
    }
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
            borderRadius: BorderRadius.circular(13.0),
          ),
          duration: const Duration(seconds: 0),
          height: widget.isContainerVisibleTwo
              ? MediaQuery.of(context).size.height * 0.57
              : 0.0,
          width: widget.isContainerVisibleTwo
              ? MediaQuery.of(context).size.width
              : 0.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: TextField(
                  onChanged: (String text) {
                    List<DataModel> searchList = [];

                    for (var element in countrycode) {
                      if (element.code
                          .toString()
                          .toLowerCase()
                          .contains(text.trim().toLowerCase())) {
                        searchList.add(element);
                      }
                    }
                    streamController.add(searchList);
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
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      debugPrint(
                                          "on tap -> ${snapshot.data![index].code}");
                                      widget.onSelect(snapshot.data![index].code);
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
                                                const Icon(Icons.image),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Container(
                                                  width: 50,
                                                  child: Text(
                                                    snapshot.data![index].code,
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
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  double.parse(snapshot
                                                          .data![index].value)
                                                      .toStringAsFixed(3),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (snapshot.data![index].fav ==
                                                        0) {
                                                      snapshot.data![index].fav = 1;
                                                    } else {
                                                      snapshot.data![index].fav = 0;
                                                    }
                                                    updateAll(snapshot.data![index].value,
                                                        snapshot.data![index].code,
                                                        snapshot.data![index].fav!,


                                                        );
                                                    countrycode=[];
                                                    orderedData();

                                                    setState(() {});
                                                  },
                                                  icon:
                                                      snapshot.data![index].fav == 1
                                                          ?  Icon(
                                                              Icons.star_sharp,
                                                              size: 30.0,
                                                              color: MyColors.colorPrimary,
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
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Divider(height: 0.7,color:Colors.grey,thickness: 0.7,))
                                ],
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

  updateAll(String value, String code, int fav, ) async {
    DataModel currencyData = DataModel(
        value: value,
        code: code,

        fav: fav,
        );
    await dbHelper.update(currencyData.toMap());
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
