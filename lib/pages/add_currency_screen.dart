import 'package:currency_converter/API/apis.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({Key? key}) : super(key: key);

  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  List<CurrencyData> currencyList = [];
  List<String> favList = [];
  Map<String, double> currencyMap = {};
  List<CurrencyData> selectedList = [];

  @override
  void initState() {
    super.initState();
    getcurrencySaveDataList();
  }

  Future getData() async {
    currencyMap = await Apiclass.getUser();
    currencyMap.forEach((key, value) {
      CurrencyData currency = CurrencyData(
        key: key.toString(),
        value: value,
      );

      int i = selectedList.indexWhere((element) => element.key == key);
      if (i != -1) {
        currency.changeIcon = true;
        currencyList.add(currency);
      } else {
        currencyList.add(currency);
      }
    });
    // setcurrencySaveListData(favList);
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
  }

  void getcurrencySaveDataList() async {
    final prefs = await SharedPreferences.getInstance();
    favList = prefs.getStringList(Constants.currencySaveData) ?? [];
    debugPrint("$favList");
    selectedList.clear();
    for (String element in favList) {
      CurrencyData data = CurrencyData.fromMap(element);
      selectedList.add(data);
    }
    debugPrint("selected List $selectedList");
    setState(() {});
    getData();
  }

  void setcurrencySaveListData(List<String> selected) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(Constants.currencySaveData, selected);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.colorPrimary,
        appBar: AppBar(
          title: Text(
            "Add currency".toUpperCase(),
            style: TextStyle(
              color: MyColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, selectedList);
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              MyColors.firstthemecolorgr1,
              MyColors.colorPrimary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Selected".toUpperCase(),
                    style: TextStyle(
                      color: MyColors.textColor,
                      fontSize: MyColors.fontsmall
                          ? (MyColors.textSize - 18) * (-1)
                          : MyColors.fontlarge
                              ? (MyColors.textSize + 18)
                              : 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(selectedList.length, (index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.image),
                        title: Row(
                          children: [
                            Text(selectedList[index].key),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              selectedList[index].value.toStringAsFixed(3),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                            onTap: () {
                              selectedList[index].changeIcon =
                                  !selectedList[index].changeIcon;

                              selectedList.removeAt(index);
                              favList.removeAt(index);

                              setcurrencySaveListData(favList);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.remove_circle_rounded,
                              size: 29,
                              color: MyColors.firstthemecolorgr,
                            )),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Currency List".toUpperCase(),
                  style: TextStyle(
                    color: MyColors.textColor,
                    fontSize: MyColors.fontsmall
                        ? (MyColors.textSize - 18) * (-1)
                        : MyColors.fontlarge
                            ? (MyColors.textSize + 18)
                            : 18,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: List.generate(currencyList.length, (index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.image),
                        title: Row(
                          children: [
                            Text(currencyList[index].key),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              currencyList[index].value.toStringAsFixed(3),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              debugPrint(
                                  "currencyList[index].changeIcon ${currencyList[index].changeIcon}");
                              if (!currencyList[index].changeIcon) {
                                currencyList[index].changeIcon =
                                    !currencyList[index].changeIcon;

                                selectedList.add(currencyList[index]);
                                favList.add(currencyList[index].toString());

                                setcurrencySaveListData(favList);
                                debugPrint("$favList");
                                setState(() {});
                              }
                            },
                            icon: currencyList[index].changeIcon
                                ? Icon(
                                    Icons.check_sharp,
                                    size: 29,
                                    color: MyColors.colorPrimary,
                                  )
                                : Icon(
                                    Icons.add,
                                    size: 29,
                                    color: MyColors.firstthemecolorgr,
                                  )),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addDataSelected() {}
}
