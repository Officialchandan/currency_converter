  import 'dart:io';

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
      body:  SingleChildScrollView(
        padding: EdgeInsets.only(left:10,right:0,top:20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Support",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
               padding: EdgeInsets.only(left:0,top:0),
              child: RichText(
                text: TextSpan(
                    text: "If you' re having an issue with our currency\nconverter app, please email to ",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(text: 'app@currency.wiki',
                          style: new TextStyle(fontWeight: FontWeight.normal,fontSize: 15,decoration: TextDecoration.underline,color: Colors.indigo)),


                    ]),


              ),

            ),

            Container(
                padding:  EdgeInsets.only(left: 15,),
                child: Text("(allow 24-48 hours for a response) and in the subject line, please add Issue with app",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),
            Container(
               padding: EdgeInsets.only(left:0,top:0),
              child: Text("Please describe the issue, including your device's name and the model number, and the current android version. e.g., Samsung Galaxy S9+ Android 10",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),

              ),
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("FAQ",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
            ),

            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("How often exchange rates update?",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Rates are updated every 30 minutes and in-time every 60 seconds except weekends (Forex market in the US closes on Friday at 5 PM EST and opens on Sunday at 5 PM EST)",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),

            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("How often cryptocurrencies update?",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("The cryptocurrency market never closes. It is open 24/7, 365 days a year. Bitcoin (BTC) rates are always updated, even on weekends",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),

            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("How to add widget?",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
            ),


            Container(
              padding:  EdgeInsets.only(left: 35,top: 15),
              child: RichText(
                text: TextSpan(
                    text: 'On your home screen, touch and hold an\n empty spot ',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(text: '\nTap on Widgets',
                          style: new TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white)),
                      TextSpan(text: '\nIn the search box, type CurrencyConverter\nand it should display a currency widget'),

                      TextSpan(text: '\nYou tap on the widget, and it will prompt you\nto select the type of widget you want to\ndisplay by holding and dragging to your\nhome screen',style:TextStyle( fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white)),    // navigate to desired screen

                    ]),


              ),

            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Why do I get one of the following system notifications?",style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
              padding:  EdgeInsets.only(left: 35,top: 15),
              child: RichText(
                text: TextSpan(
                    text: 'Stop optimizing battery usage ',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(text: '\nTap on Widgets',
                          style: new TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white)),
                      TextSpan(text: '\nLet app always run in background'),

                      TextSpan(text: '\nIgnore battery optimizations',style:TextStyle( fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white)),    // navigate to desired screen

                    ]),


              ),

            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("If you are using a currency widget on your home screen, we recommend that you allow our app to run in the background to ensure rates are always\nup to date",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Battery usage?",style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Our app was designed to use a minimum amount of battery, and when operating in the background to update rates. Please note that many factors come into play, such as closing\nthe app after usage, making sure your device is compatible with our app, etc…",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Tips",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Copy to share",style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("If you go to the main currency converter screen,\ntap, and hold results. It will copy results into the clipboard as an example, 1.00 USD = 0.84 EUR that you can share",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Calculate tips/fees/taxes",style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("We've created the following logic for quick tip calculations; if you enter example 50%10 and tap = it will calculate 10% from 50",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("Multi-converter",style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),)
            ),
            Container(
                 padding: EdgeInsets.only(left:0,top:0),
                child: Text("You may re-arrange the order of currencies in your selected list by dragging and dropping",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)
            ),
          ],

        ),
      ),
    );
  }
}
