import 'package:currency_converter/API/apis.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({Key? key}) : super(key: key);

  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  List<CurrencyData> currencyList = [];
  Map<String, double> currencyMap = {};
  List<CurrencyData> selectedList = [];
  @override
  void initState() {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.firstthemecolorgr,
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
              MyColors.firstthemecolorgr,
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
                ListView.builder(
                    itemCount: selectedList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: 32.0,
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

                              setState(() {});
                            },
                            child: selectedList[index].changeIcon
                                ? Icon(
                                    Icons.remove_circle_rounded,
                                    size: 29,
                                    color: MyColors.firstthemecolorgr,
                                  )
                                : Icon(
                                    Icons.add,
                                    size: 29,
                                    color: MyColors.firstthemecolorgr,
                                  ),
                          ),
                        ),
                      );
                    }),
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
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: currencyList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: 32.0,
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
                          trailing: InkWell(
                            onTap: () {
                              selectedList.add(currencyList[index]);

                              currencyList[index].changeIcon =
                                  !currencyList[index].changeIcon;
                              addDataSelected();
                              setState(() {});
                            },
                            child: currencyList[index].changeIcon
                                ? Icon(
                                    Icons.check_sharp,
                                    size: 29,
                                    color: MyColors.firstthemecolorgr,
                                  )
                                : Icon(
                                    Icons.add,
                                    size: 29,
                                    color: MyColors.firstthemecolorgr,
                                  ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addDataSelected() {}
}
