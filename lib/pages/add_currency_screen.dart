import 'package:currency_converter/Themes/colors.dart';
import 'package:flutter/material.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({Key? key}) : super(key: key);

  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.firstthemecolorgr,
        body: SingleChildScrollView(
          child: Container(
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
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Selected".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.ac_unit),
                        title: Row(
                          children: const [
                            Text(
                              "USA",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("united state"),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
