import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/tramandconditions/privacy_policy.dart';
import 'package:currency_converter/tramandconditions/support_page.dart';
import 'package:currency_converter/tramandconditions/terms_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class TeramAndCondition extends StatefulWidget {
  const TeramAndCondition({Key? key}) : super(key: key);

  @override
  _TeramAndConditionState createState() => _TeramAndConditionState();
}

class _TeramAndConditionState extends State<TeramAndCondition> with SingleTickerProviderStateMixin {
  late TabController _tabControllers;

  @override
  void initState() {
    super.initState();
    _tabControllers = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabControllers.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
        child: Column(
          children: [
            Container(
              height: 35,
              decoration: BoxDecoration(
                color: MyColors.textColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
              ),
              child: TabBar(
                controller: _tabControllers,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), // Creates border
                    color: MyColors.textColor.withOpacity(.9)),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.transparent,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "support".tr().toString(),
                      maxLines: 1,
                      textScaleFactor: Constants.textScaleFactor,
                      style: TextStyle(
                        fontSize: 16,
                        color: MyColors.colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "terms".tr().toString(),
                      maxLines: 1,
                      textScaleFactor: Constants.textScaleFactor,
                      style: TextStyle(
                        fontSize: 16,
                        color: MyColors.colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: AutoSizeText(
                      "privacy_policy".tr().toString(),
                      maxLines: 1,
                      textScaleFactor: Constants.textScaleFactor,

                      // maxFontSize: 22,
                      style: TextStyle(

                        color: MyColors.colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(physics: const NeverScrollableScrollPhysics(), controller: _tabControllers, children: const [
                SupportPage(),
                TermsPage(),
                PrivacyPolicyPage(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
