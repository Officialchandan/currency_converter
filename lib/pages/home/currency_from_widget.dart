import 'dart:async';

import 'package:currency_converter/API/apis.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';

import 'package:currency_converter/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class CurrencyFromWidget extends StatefulWidget {
  final Function(String currencyCode) onSelect;
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
  final StreamController<List<DataModel>> streamController =
      StreamController();
  TextEditingController edtCurrencyCode = TextEditingController();
  bool starIndex = false;
  bool _isDisposed = false;
  bool _isExpanded = false;
  Map<String, double> from = {};
  Map<String, double> to = {};
  Map<String, double> currencyMap = {};
  List<CurrencyData> currencyList = [];

  List<CurrencyData> favoriteList = [];

  List<CurrencyData> formList = [];
  List<CurrencyData> toList = [];
  @override
  void initState() {
    showAll();
    if (edtCurrencyCode.text.isEmpty) {
      edtCurrencyCode.text = "";
    }
    super.initState();
    getData();
  }

  Future getData() async {
    currencyMap = await Apiclass.getUser();

    currencyMap.forEach((key, value) {
      currencyList.add(CurrencyData(
        key: key.toString(),
        value: value,
      ));
    });
    // if (!streamController.isClosed) {
    //   streamController.sink.add(currencyList);
    // }
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
  Widget build(BuildContext context) {
    // log("===>${widget._isContainerVisible}");
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
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
          width: widget.isContainerVisible
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
              SizedBox(
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
                              return InkWell(
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
                                                if( snapshot.data![index].fav==0)
                                                  {
                                                    snapshot.data![index].fav =
                                                    1;


                                                  }
                                                else{
                                                  snapshot.data![index].fav =
                                                  0;

                                                }
                                                updateAll(snapshot.data![index].value,
                                                  snapshot.data![index].code,
                                                  snapshot.data![index].fav!,


                                                );


                                                currencyfavorite();
                                                setState(() {});
                                              },
                                              icon:
                                                  snapshot.data![index].fav==1
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

  void currencyfavorite() {
    from.forEach((key, value) {
      formList.add(CurrencyData(key: key, value: value));
    });
    debugPrint("--->>>>>>>from$from");

    debugPrint("--->>>>>>>$formList");

    for (int i = 0; i < formList.length; i++) {
      formList[i].favorite = !formList[i].favorite;

      if (formList[i].favorite) {
        favoriteList = formList.where((element) => element.favorite).toList();
        for (var element in favoriteList) {
          int i =
              formList.indexWhere((element1) => element.key == element1.key);
          CurrencyData c = formList.removeAt(i);
          formList.insert(0, c);
        }
      }
    }
    for (var element in favoriteList) {
      int i = formList.indexWhere((element1) => element.key == element1.value);
      CurrencyData c = formList.removeAt(i);
      formList.insert(0, c);
      debugPrint("---C >>>>>>>$c");
    }
  }
}
