import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:flutter/material.dart';

import 'add_currency_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<CurrencyData> selecteddata = [];
  DateTime now = DateTime.now();
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
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: selecteddata.length,
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
                                Text(selecteddata[index].key),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  selecteddata[index].value.toStringAsFixed(3),
                                ),
                              ],
                            ),
                            trailing: InkWell(
                                onTap: () {
                                  selecteddata[index].changeIcon =
                                      !selecteddata[index].changeIcon;

                                  selecteddata.removeAt(index);

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.remove_circle_rounded,
                                  size: 29,
                                  color: MyColors.colorPrimary,
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
}
