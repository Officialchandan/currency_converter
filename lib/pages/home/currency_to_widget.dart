import 'dart:async';
import 'dart:developer';

import 'package:currency_converter/API/apis.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyToWidget extends StatefulWidget {
  final Function(String currencyCode,String image) onSelect;

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

                              DataModel model = snapshot.data![index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      debugPrint(
                                          "on tap -> ${model.code}");
                                      widget
                                          .onSelect(model.code,model.image!);
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 1, 10, 0),
                                        padding: const EdgeInsets.only(left: 5),
                                        decoration: BoxDecoration(
                                          // color: MyColors.textColor,
                                          color: MyColors.textColor,

                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width:40,
                                                    height: 40,


                                                    child: ClipRRect(borderRadius:   BorderRadius.circular(20),
                                                      child: SvgPicture.asset(
                                                        model.image!,fit: BoxFit.cover,),
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 50,
                                                  child: Text(
                                                    model.code,
                                                    style: TextStyle(
                                                      color: MyColors
                                                          .insideTextFieldColor,
                                                      fontSize: MyColors
                                                              .fontsmall
                                                          ? (MyColors.textSize -
                                                                  18) *
                                                              (-1)
                                                          : MyColors.fontlarge
                                                              ? (MyColors
                                                                      .textSize +
                                                                  18)
                                                              : 18,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(model.name!,style: TextStyle(fontWeight: FontWeight.w500),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (model.fav ==
                                                        0) {
                                                      model.fav = 1;
                                                    } else {
                                                      model.fav = 0;
                                                    }
                                                    updateAll(model);
                                                    countrycode = [];
                                                    orderedData();

                                                    setState(() {});
                                                  },
                                                  icon: snapshot.data![index]
                                                              .fav ==
                                                          1
                                                      ? Icon(
                                                          Icons.star_sharp,
                                                          size: 30.0,
                                                          color: MyColors
                                                              .colorPrimary,
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Divider(
                                        height: 0.7,
                                        color: Colors.grey,
                                        thickness: 0.7,
                                      ))
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
