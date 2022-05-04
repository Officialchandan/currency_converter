import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _launchURL(String url) async {
    try {
      return await launch(url);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(top: 15),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: Constants.textScaleFactor,
                ),
                child: HtmlWidget("html_terms".tr().toString(), onTapUrl: (url) {
                  return _launchURL(url);
                },
                    textStyle: TextStyle(
                      color: MyColors.textColor,
                      fontSize: 15,
                    )),
              ))),
    );
  }
}
