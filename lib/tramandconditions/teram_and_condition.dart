import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/tramandconditions/privacy_policy.dart';
import 'package:currency_converter/tramandconditions/support_page.dart';
import 'package:currency_converter/tramandconditions/terms_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TeramAndCondition extends StatefulWidget {
  const TeramAndCondition({Key? key}) : super(key: key);

  @override
  _TeramAndConditionState createState() => _TeramAndConditionState();
}

class _TeramAndConditionState extends State<TeramAndCondition>
    with SingleTickerProviderStateMixin {
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
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
              ),
              child: TabBar(
                controller: _tabControllers,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), // Creates border
                    color: MyColors.textColor),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "Support",
                      style: TextStyle(
                        color: MyColors.colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Terms",
                      style: TextStyle(
                        color: MyColors.colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: AutoSizeText(
                      "Privacy Policy",
                      maxLines: 1,
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
