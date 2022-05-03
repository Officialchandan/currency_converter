import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                child:
                    HtmlWidget("html_terms".tr().toString(), onTapUrl: (url) {
                  HapticFeedback.vibrate();
                  return _launchURL(url);
                },
                        textStyle: TextStyle(
                          color: MyColors.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        )),
              ))),
    );
  }

  Future<bool> _launchURL(String url) async {
    try {
      return await launch(url);
    } catch (e) {
      return false;
    }
  }

  _launchURL1() async {
    const url = 'https://freeicons.io/profile/3';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL3() async {
    const url = 'https://www.flaticon.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL4() async {
    const url = 'https://www.freepik.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL5() async {
    const url = 'https://www.amcharts.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
