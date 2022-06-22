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

class _TeramAndConditionState extends State<TeramAndCondition>
    with SingleTickerProviderStateMixin {
  late TabController _tabControllers;

  List<String> tabs = ["support".tr(), "terms".tr(), "privacy_policy".tr()];

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
              height: 40,
              decoration: BoxDecoration(
                color: MyColors.isDarkMode
                    ? const Color(0xff545763)
                    : MyColors.textColor.withOpacity(.8),
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
              ),
              child: TabBar(
                controller: _tabControllers,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), // Creates border
                  color: MyColors.textColor.withOpacity(.9),
                ),
                labelColor: Colors.white,
                labelPadding: const EdgeInsets.all(0),
                unselectedLabelColor: MyColors.isDarkMode
                    ? const Color(0xff545763)
                    : Colors.transparent,
                tabs: tabs
                    .map(
                      (e) => Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          e,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          textScaleFactor: Constants.textScaleFactor,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColors.colorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabControllers,
                  children: const [
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
