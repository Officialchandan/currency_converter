import 'dart:async';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/locals.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Language extends StatefulWidget {
  final bool isContainerVisible;
  const Language({required this.isContainerVisible, Key? key})
      : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  void initState() {
    super.initState();
    print("isContainerVisible-->${widget.isContainerVisible}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.0),
          ),
          duration: const Duration(seconds: 0),
          height: widget.isContainerVisible
              ? MediaQuery.of(context).size.height
              : 0.0,
          width: widget.isContainerVisible
              ? MediaQuery.of(context).size.width
              : 0.0,
          child: Center(
              child: DefaultTextStyle(
            style: const TextStyle(decoration: TextDecoration.none),
            child: Container(
                margin: const EdgeInsets.only(
                    top: 0, right: 10, bottom: 0, left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.909,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 0, right: 10, bottom: 0, left: 10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Locals.language.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                String name = Locals.language[index].keys.first;

                                await context.setLocale(
                                    Locals.language[index].values.first);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const MyTabBarWidget()),
                                    (route) => false);
                              },
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(7),
                                      height: 30,
                                      child: Text(
                                        Locals.language[index].keys.first,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                )),
          )),
        ),
      ],
    );
  }
}
