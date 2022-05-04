import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final _scrollController = ScrollController(initialScrollOffset: 50.0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: Constants.textScaleFactor,
            ),
            child: HtmlWidget(
              "html_policy".tr().toString(),
              onTapUrl: (url) {
                HapticFeedback.vibrate();
                return _launchURL(url);
              },
              textStyle: TextStyle(
                color: MyColors.textColor,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ));
  }

  Future<bool> _launchURL(String url) async {
    try {
      return await launch(url);
    } catch (e) {
      return false;
    }
  }

  _launchURL1() async {
    const url = 'https://policies.google.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL2() async {
    const url = 'https://policies.google.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL3() async {
    const url = 'https://support.google.com/analytics/answer/6004245';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL4() async {
    const url = 'https://policies.google.com/technologies/partner-sites';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL5() async {
    const url = 'https://www.facebook.com/about/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL6() async {
    const url = 'https://support.google.com/ads/answer/2662922?hl=en';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL7() async {
    const url = 'https://policies.google.com/technologies/partner-sites';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL8() async {
    const url = 'https://www.facebook.com/about/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL9() async {
    const url = 'https://www.google.com/policies/privacy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
