import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

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
    unselectedList.addAll(selectedList);
    List<DataModel> data = await dbHelper.getUnselectedData();
    unselectedList.addAll(data);
    selectedController.add(selectedList);
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
            "addCurrency".tr().toString(),
            style: TextStyle(
              color: MyColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
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
                    style: TextStyle(
                      color: MyColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                                          margin: EdgeInsets.only(right: 15),
                                          width: 35,
                                          height: 35,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.asset(
                                                data.image!,
                                                fit: BoxFit.cover,
                                              ))),
                                      Text(
                                        data.code,
                                        style: TextStyle(
                                          color: MyColors.insideTextFieldColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: AutoSizeText(
                                          data.name!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                MyColors.insideTextFieldColor,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            data.iconForSelection =
                                                !data.iconForSelection;
                                            int i = unselectedList.indexWhere(
                                                (element) =>
                                                    element.code == data.code);

                                            unselectedList[i].iconForSelection =
                                                false;

                                            data.iconForSelection = false;
                                            data.selected = 0;
                                            dbHelper.update(data.toMap());

                                            selectedList.removeAt(index);
                                            selectedController
                                                .add(selectedList);
                                            unselectedController
                                                .add(unselectedList);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 29,
                                            color: MyColors.colorPrimary,
                                          )),
                                    ],
                                  )
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
                  "currencyList".tr().toString(),
                  style: TextStyle(
                    color: MyColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
                                          width: 35,
                                          height: 35,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                        style: TextStyle(
                                          color: MyColors.insideTextFieldColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
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
                                          model.name!,
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
                                          ? Icon(
                                              Icons.check_sharp,
                                              size: 29,
                                              color: MyColors.colorPrimary,
                                            )
                                          : Icon(
                                              Icons.add,
                                              size: 29,
                                              color: MyColors.colorPrimary,
                                            )),
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
