import 'dart:io';

import 'package:currency_converter/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("Privacy Policy",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Last updated: March 13, 2021\n\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: MyColors.textColor,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text("Interpretation and Definitions",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Interpretation',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 22),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                    "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text("Definitions",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text("For the purposes of this Privacy Policy:",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Account',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' means a unique account created for You to access our Service or parts of our Service. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Affiliate ',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    'means an entity that controls, is controlled by or is under common control with a party, where control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Application',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' means the software program provided by the Company downloaded by You on any electronic device, named Currency Converter App by Currency.Wiki',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Country refers to:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'California, United States ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Company',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    '(referred to as either the Company, We, Us or Our in this Agreement) refers to Currency.Wiki, 122 15th st #431 Del Mar, CA 92014. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Device ',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    'means any device that can access the Service such as a computer, a cellphone or a digital tablet. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'In-app Purchase ',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' refers to the purchase of a product, item, service or Subscription made through the Application and subject to these Terms and Conditions and/or the Application Stores own terms and conditions. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Service',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text: ' refers to the Application. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Subscriptions ',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' refer to the services or access to the Service offered on a subscription basis by the Company to You.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' (also referred as Terms) mean these Terms and Conditions that form the entire agreement between You and the Company regarding the use of the Service.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Third-party Social Media Service',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' means any services or content (including data, information, products or services) provided by a third-party that may be displayed, included or made available by the Service.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'You',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text("Collecting and Using Your Personal Data",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text("Types of Data Collected",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Personal Data\n\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: MyColors.textColor,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Email address',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: MyColors.textColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Usage Data',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: MyColors.textColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Usage Data\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 20),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'Usage Data is collected automatically when using the Service.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'Usage Data may include information such as Your Devices Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text("Use of Your Personal Data",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                    "The Company may use Personal Data for the following purposes:",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'To provide and maintain our Service,',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' including to monitor the usage of our Service. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'To manage Your Account',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    'to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'For the performance of a contract:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'To contact You:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile applications push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'To provide You',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'To manage Your requests:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' To attend and manage Your requests to Us.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'For business transfers:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'For other purposes:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                    "We may share Your personal information in the following situations:",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'With Service Providers',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to show advertisements to You to help support and maintain Our Service, for payment processing, to contact You.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'For business transfers:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    '  We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'With Affiliates:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'With business partners:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' We may share Your information with Our business partners to offer You certain products, services or promotions.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'With other users: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside. If You interact with other users or register through a Third-Party Social Media Service, Your contacts on the Third-Party Social Media Service may see Your name, profile, pictures and description of Your activity. Similarly, other users will be able to view descriptions of Your activity, communicate with You and view Your profile.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'With Your consent',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    ' We may disclose Your personal information for any other purpose with Your consent. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Retention of Your Personal Data\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 22),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Transfer of Your Personal Data\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 25),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'Your information, including Personal Data, is processed at the Companys operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text("Disclosure of Your Personal Data ",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Business Transactions\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 20),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Law enforcement\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 20),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Other legal requirements\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 20),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: 'Comply with a legal obligation',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.textColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text:
                                'Protect and defend the rights or property of the Company',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.textColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text:
                                'Prevent or investigate possible wrongdoing in connection with the Service',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.textColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text:
                                'Protect the personal safety of Users of the Service or the public',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.textColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: 'Protect against legal liability',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.textColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: 'Security of Your Personal Data',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.textColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Security of Your Personal Data\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 25),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text:
                        'Detailed Information on the Processing of Your Personal Data"\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 25),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'The Service Providers We use may have access to Your Personal Data. These third-party vendors collect, store, use, process and transfer information about Your activity on Our Service in accordance with their Privacy Policies',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Analytics\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 25),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'We may use third-party Service providers to monitor and analyze the use of our Service.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\u2022 ",
                        style:
                            TextStyle(fontSize: 18, color: MyColors.textColor),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Google Analytics\n',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: MyColors.textColor,
                                fontSize: 16),
                            children: const <TextSpan>[
                              TextSpan(
                                  text:
                                      'Google Analytics is a web analytics service offered by Google that tracks and reports website traffic. Google uses the data collected to track and monitor the use of our Service. This data is shared with other Google services. Google may use the collected data to contextualize and personalize the ads of its own advertising network.\n\n',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(
                  left: 40,
                ),
                child: Text(
                    "You may opt-out of certain Google Analytics features through your mobile device settings, such as your device advertising settings or by following the instructions provided by Google in their Privacy Policy",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: MyColors.textColor)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: GestureDetector(
                    onTap: _launchURL,
                    child: Text(
                      'https://policies.google.com/privacy.',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 40, top: 15),
                child: Text(
                    "For more information on the privacy practices of Google, please visit the Google Privacy & Terms web page",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: MyColors.textColor)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: GestureDetector(
                    onTap: _launchURL1,
                    child: Text(
                      'https://policies.google.com/privacy.',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Firebase\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    'Firebase is an analytics service provided by Google Inc.\n\n',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                            TextSpan(
                                text:
                                    'You may opt-out of certain Firebase features through your mobile device settings, such as your device advertising settings or by following the instructions provided by Google in their Privacy Policy:',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: GestureDetector(
                    onTap: _launchURL2,
                    child: Text(
                      'https://policies.google.com/privacy.',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Container(
                  child: Text(
                    'We also encourage you to review the Googles policy for safeguarding your data:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: MyColors.textColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: GestureDetector(
                    onTap: _launchURL3,
                    child: Text(
                      'https://support.google.com/analytics/answer/6004245',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Text(
                    'For more information on what type of information Firebase collects, please visit the How Google uses data when you use our partners sites or apps webpage: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: MyColors.textColor)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: GestureDetector(
                    onTap: _launchURL4,
                    child: Text(
                      'https://policies.google.com/technologies/partner-sites',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'AppsFlyer\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Their Privacy Policy can be viewed at',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: GestureDetector(
                    onTap: _launchURL5,
                    child: Text(
                      'https://www.appsflyer.com/privacy-policy/',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 18, color: MyColors.textColor),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Facebook App Ads\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: MyColors.textColor),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Their Privacy Policy can be viewed at',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: GestureDetector(
                    onTap: _launchURL5,
                    child: Text(
                      'https://www.facebook.com/about/privacy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Advertising\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: MyColors.textColor,
                        fontSize: 25),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'We may use third-party Service providers to monitor and analyze the use of our Service.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\u2022 ",
                        style:
                            TextStyle(fontSize: 18, color: MyColors.textColor),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'AdMob by Google\n\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: MyColors.textColor,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                  text:
                                      'AdMob by Google is provided by Google Inc.\n\n',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextSpan(
                                  text:
                                      'You can opt-out from the AdMob by Google service by following the instructions described by Google:',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: GestureDetector(
                    onTap: _launchURL6,
                    child: Text(
                      'https://support.google.com/ads/answer/2662922?hl=en',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(
                    left: 35,
                  ),
                  child: Row(
                    children: [
                      Text(      
                          'For more information on how Google\n usesthe collected information,\n please visit the"How Google uses\n data when you use our\n partners sites or app"page',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: MyColors.textColor,
                          )),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: GestureDetector(
                    onTap: _launchURL7,
                    child: Text(
                      'https://policies.google.com/technologies/partner-sites',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: RichText(
                    text: TextSpan(
                        text: 'or visit the Privacy Policy of Google:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: MyColors.textColor,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: GestureDetector(
                    onTap: _launchURL8,
                    child: Text(
                      'https://www.facebook.com/about/privacy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Payments\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: MyColors.textColor),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'We may provide paid products and/or services within the Service. In that case, we may use third-party services for payment processing (e.g. payment processors).\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'We will not store or collect Your payment card details. That information is provided directly to Our third-party payment processors whose use of Your personal information is governed by their Privacy Policy. These payment processors adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, Mastercard, American Express and Discover. PCI-DSS requirements help ensure the secure handling of payment information.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\u2022 ",
                        style:
                            TextStyle(fontSize: 18, color: MyColors.textColor),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Google Play In-App Payments\n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: MyColors.textColor),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Their Privacy Policy can be viewed at',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: GestureDetector(
                    onTap: _launchURL9,
                    child: Text(
                      'https://www.google.com/policies/privacy/',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.indigo,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Childrens Privacy\n\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: MyColors.textColor,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parents consent before We collect and use that information.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Links to Other Websites\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: MyColors.textColor),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third partys site. We strongly advise You to review the Privacy Policy of every site You visit.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Changes to this Privacy Policy\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: MyColors.textColor),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Contact Us\n\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: MyColors.textColor,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'If you have any questions about these Terms and Conditions, You can contact us:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, top: 10, bottom: 50),
                child: Text("By email: info@currency.wiki",
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          )),
    );
  }

  _launchURL() async {
    const url = 'https://policies.google.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
