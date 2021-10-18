  import 'dart:io';

import 'package:currency_converter/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8,right:8),

        child: Container(
          padding:  EdgeInsets.only(left: 10,top: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                  child: Text("Support",style: TextStyle(fontSize: 26,color:MyColors.textColor,fontWeight: FontWeight.w900),)
              ),
              Container(
                padding:  EdgeInsets.only(top: 15),
                child: RichText(
                  text: TextSpan(
                      text: "If you' re having an issue with our currency converter app, please email to ",
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: MyColors.textColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'app@currency.wiki',
                            style:  TextStyle(fontWeight: FontWeight.w600,fontSize: 14,decoration: TextDecoration.underline,color: Colors.indigo)),


                      ]),


                ),

              ),

              Container(

                  child: Text("(allow 24-48 hours for a response) and in the subject line, please add Issue with app",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),)
              ),
              Container(
                padding:  EdgeInsets.only(top: 15),
                child: Text("Please describe the issue, including your device's name and the model number, and the current android version. e.g., Samsung Galaxy S9+ Android 10",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),

                ),
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("FAQ",style: TextStyle(fontSize: 25,color: MyColors.textColor,fontWeight: FontWeight.w900),)
              ),

              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("How often exchange rates update?",style: TextStyle(fontSize: 21,color: MyColors.textColor,fontWeight: FontWeight.w800),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Rates are updated every 30 minutes and in-time every 60 seconds except weekends (Forex market in the US closes on Friday at 5 PM EST and opens on Sunday at 5 PM EST)",style: TextStyle(fontSize: 15,color: MyColors.textColor ,fontWeight: FontWeight.w600),)
              ),

              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("How often cryptocurrencies update?",style: TextStyle(fontSize: 21,color:MyColors.textColor,fontWeight: FontWeight.w800),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("The cryptocurrency market never closes. It is open 24/7, 365 days a year. Bitcoin (BTC) rates are always updated, even on weekends",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),)
              ),

              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("How to add widget?",style: TextStyle(fontSize: 22,color:MyColors.textColor,fontWeight: FontWeight.w800),)
              ),


              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'On your home screen,touch and hold an empty spot',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Tap on Widgets',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'In the search box, type CurrencyConverter and it should display a currency widget',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'You tap on the widget, and it will prompt you to select the type of widget you want to display by holding and dragging to your home screen',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),

                      ),
                    ),
                  ],
                ),
              ),


              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Why do I get one of the following system notifications?",style: TextStyle(fontSize: 22,color: MyColors.textColor,fontWeight: FontWeight.w800),)
              ),

              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Stop optimizing battery usage',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20 ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Do not optimize battery usage',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20 ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Let app always run in background',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(

                padding: EdgeInsets.only(left: 20 ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022 ",
                      style: TextStyle(fontSize: 15, color: MyColors.textColor,fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Ignore battery optimizations',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15,color: MyColors.textColor),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("If you are using a currency widget on your home screen, we recommend that you allow our app to run in the background to ensure rates are always up to date",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Battery usage?",style: TextStyle(fontSize: 23,color: MyColors.textColor,fontWeight: FontWeight.w900),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Our app was designed to use a minimum amount of battery, and when operating in the background to update rates. Please note that many factors come into play, such as closing the app after usage, making sure your device is compatible with our app, etc…",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Tips",style: TextStyle(fontSize: 25,color: MyColors.textColor,fontWeight: FontWeight.w900),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Copy to share",style: TextStyle(fontSize: 24,color: MyColors.textColor,fontWeight: FontWeight.w900),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("If you go to the main currency converter screen,tap, and hold results. It will copy results into the clipboard as an example, 1.00 USD = 0.84 EUR that you can share",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Calculate tips/fees/taxes",style: TextStyle(fontSize: 23,color: MyColors.textColor,fontWeight: FontWeight.w900),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("We've created the following logic for quick tip calculations; if you enter example 50%10 and tap = it will calculate 10% from 50",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15),
                  child: Text("Multi-converter",style: TextStyle(fontSize: 23,color: MyColors.textColor,fontWeight: FontWeight.w900),)
              ),
              Container(
                  padding:  EdgeInsets.only(top: 15,bottom: 20),
                  child: Text("You may re-arrange the order of currencies in your selected list by dragging and dropping",style: TextStyle(fontSize: 15,color: MyColors.textColor,fontWeight: FontWeight.w600),)
              ),
            ],

          ),
        ),
      ),
    );
  }
}
