import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({Key? key}) : super(key: key);

  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  List<DataModel> unselectedList = [];
  List<DataModel> selectedList = [];
  final dbHelper = DatabaseHelper.instance;

  StreamController<List<DataModel>> unselectedController = StreamController();
  StreamController<List<DataModel>> selectedController = StreamController();

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  void getAllData() async {
    selectedList.clear();
    selectedList = await dbHelper.getSelectedData();
    selectedController.add(selectedList);

    unselectedList = await dbHelper.getUnselectedData();
    unselectedController.add(unselectedList);

    debugPrint("selectedList $selectedList");
    debugPrint("unselectedList $unselectedList");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.colorPrimary,
          title: Text(
            "title_add_currency".tr().toString(),
            textScaleFactor: Constants.textScaleFactor,
            style: TextStyle(
              color: MyColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/images/arrow-left.svg",
              color: MyColors.textColor,
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SecondScreen()));

              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              MyColors.colorPrimary.withOpacity(0.7),
              MyColors.colorPrimary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: Text(
                    "selected".tr().toString(),
                    textScaleFactor: Constants.textScaleFactor,
                    style: TextStyle(
                      color: MyColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<List<DataModel>>(
                    initialData: const [],
                    stream: selectedController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        debugPrint("onTap3->${selectedList.length}");
                        return Column(
                          children:
                              List.generate(snapshot.data!.length, (index) {
                            DataModel data = snapshot.data![index];
                            return Container(
                              height: 45,
                              margin: const EdgeInsets.only(top: 1.0),
                              padding: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: MyColors.textColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          width: 40,
                                          height: 40,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.asset(
                                                data.image!,
                                                fit: BoxFit.cover,
                                              ))),
                                      Text(
                                        data.code,
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: TextStyle(
                                          color: MyColors.insideTextFieldColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: AutoSizeText(
                                          data.code.toUpperCase().tr(),
                                          textScaleFactor:
                                              Constants.textScaleFactor,
                                          // data.name!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                MyColors.insideTextFieldColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          debugPrint("onTap");
                                          data.iconForSelection =
                                              !data.iconForSelection;

                                          int i = selectedList.indexWhere(
                                              (element) =>
                                                  element.code == data.code);

                                          debugPrint("i---->$i");
                                          selectedList[i].iconForSelection =
                                              false;
                                          data.iconForSelection = false;
                                          data.selected = 0;
                                          data.timeStamp = 0;

                                          dbHelper.update(data.toMap());
                                          if (data.code ==
                                              await Utility.getStringPreference(
                                                  "code")) {
                                            await Utility.setStringPreference(
                                                "value", "1");
                                            await Utility.setStringPreference(
                                                "code", "");
                                          }

                                          debugPrint(
                                              "onTap1->${selectedList.length}");

                                          unselectedList.add(selectedList[i]);
                                          selectedList.removeAt(index);
                                          debugPrint(
                                              "onTap2->${selectedList.length}");

                                          selectedController.add(selectedList);

                                          unselectedList.sort((a, b) =>
                                              a.code.compareTo(b.code));

                                          unselectedController
                                              .add(unselectedList);
                                        },
                                        child: SvgPicture.asset(
                                          "assets/images/close.svg",
                                          color: MyColors.colorPrimary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7.3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      }

                      return Container();
                    }),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "currency_list".tr().toString(),
                  textScaleFactor: Constants.textScaleFactor,
                  style: TextStyle(
                    color: MyColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.5,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StreamBuilder<List<DataModel>>(
                    initialData: const [],
                    stream: unselectedController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        log("snapshot error-->${snapshot.data}");
                      }

                      if (snapshot.hasData) {
                        log("snapshot-->${snapshot.data}");

                        return Column(
                          children:
                              List.generate(snapshot.data!.length, (index) {
                            DataModel model = snapshot.data![index];
                            return Container(
                              height: 45,
                              margin: const EdgeInsets.only(top: 1.0),
                              padding: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: MyColors.textColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              // alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          width: 40,
                                          height: 40,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                model.image!,
                                                fit: BoxFit.cover,
                                              ))),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      SizedBox(
                                          child: AutoSizeText(
                                        model.code,
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: TextStyle(
                                          color: MyColors.insideTextFieldColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .45,
                                        child: AutoSizeText(
                                          model.code.toUpperCase().tr(),
                                          textScaleFactor:
                                              Constants.textScaleFactor,
                                          // model.name!,
                                          maxLines: 1,
                                          minFontSize: 15,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                MyColors.insideTextFieldColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.only(left: 10),
                                    onPressed: () async {
                                      if (!model.iconForSelection) {
                                        model.iconForSelection = true;
                                        model.selected = 1;
                                        model.timeStamp = DateTime.now()
                                            .millisecondsSinceEpoch;
                                        dbHelper.update(model.toMap());
                                        selectedList.add(model);
                                        selectedController.add(selectedList);
                                        unselectedList[index] = model;
                                        unselectedController
                                            .add(unselectedList);
                                      }
                                    },
                                    icon: model.iconForSelection
                                        ? SvgPicture.asset(
                                            "assets/images/right.svg",
                                            color: MyColors.colorPrimary,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/plus-icon.svg",
                                            color: MyColors.colorPrimary,
                                          ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      }

                      return Container();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addDataSelected() {}
}
