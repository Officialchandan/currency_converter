import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_currency_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<CurrencyData> selecteddata = [];
  List<String> favList = [];
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    getcurrencySaveDataListAdd();
  }

  void getcurrencySaveDataListAdd() async {
    final prefs = await SharedPreferences.getInstance();
    favList = prefs.getStringList(Constants.currencySaveData) ?? [];
    debugPrint("$favList");
    selecteddata.clear();
    for (String element in favList) {
      CurrencyData data = CurrencyData.fromMap(element);
      selecteddata.add(data);
    }
    debugPrint("selected List $selecteddata");
    setState(() {});
  }

  void setcurrencySaveListData(List<String> selected) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(Constants.currencySaveData, selected);
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: appheight,
        width: appwidth,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: appwidth * 0.14,
                      ),
                      Row(
                        children: [
                          Center(
                            child: Text(
                              "Updated:",
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
                            width: 5,
                          ),
                          MyColors.datemm
                              ? Center(
                                  child: Text(
                                    "${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year.toString()}",
                                    style: TextStyle(
                                      color: MyColors.textColor,
                                      fontSize: MyColors.fontsmall
                                          ? (MyColors.textSize - 18) * (-1)
                                          : MyColors.fontlarge
                                              ? (MyColors.textSize + 18)
                                              : 18,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}",
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
                        ],
                      ),
                      const Icon(
                        Icons.share,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: ReorderableListView.builder(
                    itemCount: selecteddata.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        key: ValueKey(selecteddata[index].key),
                        margin: const EdgeInsets.only(top: 2),
                        width: 32.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.image),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                selecteddata[index].key,
                                style: TextStyle(
                                  color: MyColors.insideTextFieldColor,
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 18) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 18)
                                          : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                selecteddata[index].value.toStringAsFixed(3),
                                style: TextStyle(
                                  color: MyColors.insideTextFieldColor,
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 18) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 18)
                                          : 18,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  cursorWidth: 2.3,
                                  // controller: calculateCurrency,
                                  showCursor: true,
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.none,
                                  style: TextStyle(
                                    color: MyColors.insideTextFieldColor,
                                    fontSize: MyColors.fontsmall
                                        ? (MyColors.textSize - 18) * (-1)
                                        : MyColors.fontlarge
                                            ? (MyColors.textSize + 18)
                                            : 18,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onTap: () {
                                    showCalculator(context);
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () {
                                selecteddata[index].changeIcon =
                                    !selecteddata[index].changeIcon;

                                selecteddata.removeAt(index);
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
                    },
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final element = selecteddata.removeAt(oldIndex);
                        selecteddata.insert(newIndex, element);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          selecteddata = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCurrency()));
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Color(0xFF6A78CA),
        ),
      ),
    );
  }

  void showCalculator(BuildContext context) {}
}
