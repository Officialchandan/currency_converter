import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/locals.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  final bool isContainerVisible;
  const Language({required this.isContainerVisible, Key? key})
      : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int? trueIndex;
  @override
  void initState() {
    super.initState();

    getIndex();

    // Future.delayed(Duration(seconds: 3));

    print("isContainerVisible-->${widget.isContainerVisible}");
  }

  @override
  Widget build(BuildContext context) {
    return widget.isContainerVisible
        ? AnimatedContainer(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.0),
            ),
            duration: const Duration(seconds: 0),
            // height: widget.isContainerVisible ? double.nan : 0.0,
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(top: 15, right: 10, bottom: 0, left: 10),
            child: Column(
                children: List.generate(Locals.language.length, (index) {
              debugPrint(
                  "language->${Locals.language[index].values.first.languageCode}");

              return GestureDetector(
                onTap: () async {
                  for (int i = 0; i < Locals.icon.length; i++) {
                    if (index == i) {
                      Utility.setLangIndexPreference("LanuageIndex", index);
                      Locals.icon[i] = true;
                    } else {
                      Locals.icon[i] = false;
                    }
                  }

                  String name = Locals.language[index].keys.first;

                  await context.setLocale(Locals.language[index].values.first);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MyTabBarWidget()),
                      (route) => false);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 1),
                  color: MyColors.textColor,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(7),
                              padding: index == 0 || index == 18
                                  ? EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.481)
                                  : EdgeInsets.only(left: 0),
                              height: 30,
                              child: Text(
                                Locals.language[index].keys.first,
                                textScaleFactor: Constants.textScaleFactor,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.insideTextFieldColor,
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Locals.icon[index]
                                ? Icon(
                                    Icons.check_sharp,
                                    color: MyColors.colorPrimary,
                                  )
                                : Text(
                                    "",
                                    textScaleFactor: Constants.textScaleFactor,
                                  ),
                          )
                        ],
                      ),
                      Divider(
                        height: 0.5,
                        color: Colors.black,
                        thickness: .3,
                      )
                    ],
                  ),
                ),
              );
            })),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  void getIndex() async {
    trueIndex = await Utility.getLangIndexPreference("LanuageIndex");
    for (int i = 0; i < Locals.icon.length; i++) {
      if (trueIndex == i) {
        Locals.icon[i] = true;
      } else {
        Locals.icon[i] = false;
      }
    }
    setState(() {});
  }
}
