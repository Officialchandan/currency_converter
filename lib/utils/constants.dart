import 'package:currency_converter/pages/setting_screen.dart';
import 'package:flutter/material.dart';

enum Fonts { small, medium, large }

class Constants {
  static LColor? isdensityColor;
  // static Map<String, PurchaseDetails>? purchase;
  // static PurchaseDetails? previousPurchase;
  static bool getAppPurchase = false;
  // static late AppsflyerSdk appsflyerSdk;
  static bool removeAdsTrue = false;
  static bool removeAd = false;
  static int isPurchaseOfAds = 0;
  static DateTime timeNow = DateTime.now();
  static String inputValue = "1";
  static const String currencyInputValue = "currencyInputValue";
  static const String newInputValue = "newInputValue";
  static const String indexByValue = "indexByValue";
  static const String indexByValueOnChange = "indexByValueOnChange";
  static const String checkWidgetPurchaseAds = 'checkWidgetPurchaseAds';
  static const String yearCheckTimeCons = "yearCheckTimeCons";
  static String isPurchaseOfColors = "[]";
  static const String isIndexTrue = "isIndexTrue";

  static const String isDarkMode = "isDarkMode";
  static const String SELECTED_CODE = "SELECTED_CODE";
  static const String SELECTED_FLAG = "SELECTED_FLAG";
  static const String SELECTED_SYMBOL = "SELECTED_SYMBOL";
  static const String GET_ID = "GET_ID";

  static const String MultiConverter = "MultiConverter";
  static const String REMOVE_AD = "REMOVE_AD";
  static const String currencyCodeFrom = "currencyCodeFrom";
  static const String currencyCodeTo = "currencyCodeTo";
  static const String openViaWidgetStatus = "openViaWidgetStatus";
  static const String widgetTransparent = "widgetTransparent";
  static const String themeColor = "theme";
  static const String themeofDensityColor = "themeofDensityColor";
  static const String currencySaveData = "currencysavedata";
  static const String monetaryFormat = "monetaryFormat";
  static const String decimalFormat = "decimalFormat";
  static const String DATE_FROMAT = "DATE_FORMAT";
  static const String ddMmYyyy = "dd_mm_yyyy";
  static const String mmDdYyyy = "mm_dd_yyyy";
  static const String fontSize = "fontSize";
  static const String fontSmall = "fontSmall";
  static const String fontMedium = "fontMedium";
  static const String fontLarge = "fontLarge";
  static const String selectedLockedColor = "selected_locked_color";
  static const String primaryColorCode = "primaryColorCode";
  static String dateFormat = mmDdYyyy;
  static String selectedFontSize = fontSmall;
  static double textScaleFactor = 0.9;

  static String selectedEditableCurrencyCode = "";
  static String selectedEditableCurrencyValue = "";

  static List<MColor> unlockColors = [
    MColor(mainColor: const Color(0xff4e7dcb), densityColors: const [
      Color(0xffc9d8ef),
      Color(0xffb8cbea),
      Color(0xffa6bee5),
      Color(0xff94b1df),
      Color(0xff83a4da),
      Color(0xff7197d5),
      Color(0xff5f8ad0),
      Color(0xff4e7dcb),
      Color(0xff4e7dcb),
      Color(0xff4670b6),
      Color(0xff3e64a2),
      Color(0xff36578e),
      Color(0xff2e4b79),
      Color(0xff273e65),
      Color(0xff1f3251),
      Color(0xff17253c),
      Color(0xff0f1928),
      Color(0xff070c14),
      Color(0xff000000),
    ]),
    MColor(mainColor: const Color(0xff54a925), densityColors: const [
      Color(0xffcbe5bd),
      Color(0xffbadca7),
      Color(0xffa9d492),
      Color(0xff98CB7C),
      Color(0xff87C266),
      Color(0xff76BA50),
      Color(0xff65B13A),
      Color(0xff54a925),
      Color(0xff43871D),
      Color(0xff3A7619),
      Color(0xff326516),
      Color(0xff295412),
      Color(0xff21430E),
      Color(0xff19320B),
      Color(0xff102107),
      Color(0xff081003),
      Color(0xff000000),
    ]),
    MColor(mainColor: const Color(0xffc95856), densityColors: const [
      Color(0xfff4dddd),
      Color(0xffeecccc),
      Color(0xffe9bcbb),
      Color(0xffe4abaa),
      Color(0xffde9a99),
      Color(0xffd98a88),
      Color(0xffd37977),
      Color(0xffce6866),
      Color(0xffc95856),
      Color(0xffc95856),
      Color(0xffb44f4d),
      Color(0xffa04644),
      Color(0xff8c3d3c),
      Color(0xff783433),
      Color(0xff642c2b),
      Color(0xff502322),
      Color(0xff3c1a19),
      Color(0xff281111),
      Color(0xff140808),
      Color(0xff000000),
    ]),
    MColor(mainColor: const Color(0xffffa415), densityColors: const [
      Color(0xffffdaa1),
      Color(0xffffd18a),
      Color(0xffffc872),
      Color(0xffffbf5b),
      Color(0xffffb643),
      Color(0xffffad2c),
      Color(0xffffa415),
      Color(0xffffa415),
      Color(0xffe59312),
      Color(0xffcc8310),
      Color(0xffb2720e),
      Color(0xff99620c),
      Color(0xff7f520a),
      Color(0xff664108),
      Color(0xff4c3106),
      Color(0xff332004),
      Color(0xff191002),
      Color(0xff000000),
    ]),
  ];

  static final List<LColor> lockedColors = [
    LColor(lmainColor: Colors.red, ldensityColors: [
      Colors.red.shade50,
      Colors.red.shade100,
      Colors.red.shade200,
      Colors.red.shade300,
      Colors.red.shade400,
      Colors.red.shade500,
      Colors.red.shade600,
      Colors.red.shade700,
      Colors.red.shade800,
      Colors.red.shade900,
    ]),
    LColor(lmainColor: Colors.pink, ldensityColors: [
      Colors.pink.shade50,
      Colors.pink.shade100,
      Colors.pink.shade200,
      Colors.pink.shade300,
      Colors.pink.shade400,
      Colors.pink.shade500,
      Colors.pink.shade600,
      Colors.pink.shade700,
      Colors.pink.shade800,
      Colors.pink.shade900,
    ]),
    LColor(lmainColor: Colors.purple, ldensityColors: [
      Colors.purple.shade50,
      Colors.purple.shade100,
      Colors.purple.shade200,
      Colors.purple.shade300,
      Colors.purple.shade400,
      Colors.purple.shade500,
      Colors.purple.shade600,
      Colors.purple.shade700,
      Colors.purple.shade800,
      Colors.purple.shade900,
    ]),
    LColor(lmainColor: Colors.deepPurple, ldensityColors: [
      Colors.deepPurple.shade50,
      Colors.deepPurple.shade100,
      Colors.deepPurple.shade200,
      Colors.deepPurple.shade300,
      Colors.deepPurple.shade400,
      Colors.deepPurple.shade500,
      Colors.deepPurple.shade600,
      Colors.deepPurple.shade700,
      Colors.deepPurple.shade800,
      Colors.deepPurple.shade900,
    ]),
    LColor(lmainColor: Colors.indigo, ldensityColors: [
      Colors.indigo.shade50,
      Colors.indigo.shade100,
      Colors.indigo.shade200,
      Colors.indigo.shade300,
      Colors.indigo.shade400,
      Colors.indigo.shade500,
      Colors.indigo.shade600,
      Colors.indigo.shade700,
      Colors.indigo.shade800,
      Colors.indigo.shade900,
    ]),
    LColor(lmainColor: Colors.blue, ldensityColors: [
      Colors.blue.shade50,
      Colors.blue.shade100,
      Colors.blue.shade200,
      Colors.blue.shade300,
      Colors.blue.shade400,
      Colors.blue.shade500,
      Colors.blue.shade600,
      Colors.blue.shade700,
      Colors.blue.shade800,
      Colors.blue.shade900,
    ]),
    LColor(lmainColor: Colors.lightBlue, ldensityColors: [
      Colors.lightBlue.shade50,
      Colors.lightBlue.shade100,
      Colors.lightBlue.shade200,
      Colors.lightBlue.shade300,
      Colors.lightBlue.shade400,
      Colors.lightBlue.shade500,
      Colors.lightBlue.shade600,
      Colors.lightBlue.shade700,
      Colors.lightBlue.shade800,
      Colors.lightBlue.shade900,
    ]),
    LColor(lmainColor: Colors.cyan, ldensityColors: [
      Colors.cyan.shade50,
      Colors.cyan.shade100,
      Colors.cyan.shade200,
      Colors.cyan.shade300,
      Colors.cyan.shade400,
      Colors.cyan.shade500,
      Colors.cyan.shade600,
      Colors.cyan.shade700,
      Colors.cyan.shade800,
      Colors.cyan.shade900,
    ]),
    LColor(lmainColor: Colors.teal, ldensityColors: [
      Colors.teal.shade50,
      Colors.teal.shade100,
      Colors.teal.shade200,
      Colors.teal.shade300,
      Colors.teal.shade400,
      Colors.teal.shade500,
      Colors.teal.shade600,
      Colors.teal.shade700,
      Colors.teal.shade800,
      Colors.teal.shade900,
    ]),
    LColor(lmainColor: Colors.green, ldensityColors: [
      Colors.green.shade50,
      Colors.green.shade100,
      Colors.green.shade200,
      Colors.green.shade300,
      Colors.green.shade400,
      Colors.green.shade500,
      Colors.green.shade600,
      Colors.green.shade700,
      Colors.green.shade800,
      Colors.green.shade900,
    ]),
    LColor(lmainColor: Colors.lightGreen, ldensityColors: [
      Colors.lightGreen.shade50,
      Colors.lightGreen.shade100,
      Colors.lightGreen.shade200,
      Colors.lightGreen.shade300,
      Colors.lightGreen.shade400,
      Colors.lightGreen.shade500,
      Colors.lightGreen.shade600,
      Colors.lightGreen.shade700,
      Colors.lightGreen.shade800,
      Colors.lightGreen.shade900,
    ]),
    LColor(lmainColor: Colors.lime, ldensityColors: [
      Colors.lime.shade50,
      Colors.lime.shade100,
      Colors.lime.shade200,
      Colors.lime.shade300,
      Colors.lime.shade400,
      Colors.lime.shade500,
      Colors.lime.shade600,
      Colors.lime.shade700,
      Colors.lime.shade800,
      Colors.lime.shade900,
    ]),
    LColor(lmainColor: Colors.yellow, ldensityColors: [
      Colors.yellow.shade50,
      Colors.yellow.shade100,
      Colors.yellow.shade200,
      Colors.yellow.shade300,
      Colors.yellow.shade400,
      Colors.yellow.shade500,
      Colors.yellow.shade600,
      Colors.yellow.shade700,
      Colors.yellow.shade800,
      Colors.yellow.shade900,
    ]),
    LColor(lmainColor: Colors.amber, ldensityColors: [
      Colors.amber.shade50,
      Colors.amber.shade100,
      Colors.amber.shade200,
      Colors.amber.shade300,
      Colors.amber.shade400,
      Colors.amber.shade500,
      Colors.amber.shade600,
      Colors.amber.shade700,
      Colors.amber.shade800,
      Colors.amber.shade900,
    ]),
    LColor(lmainColor: Colors.orange, ldensityColors: [
      Colors.orange.shade50,
      Colors.orange.shade100,
      Colors.orange.shade200,
      Colors.orange.shade300,
      Colors.orange.shade400,
      Colors.orange.shade500,
      Colors.orange.shade600,
      Colors.orange.shade700,
      Colors.orange.shade800,
      Colors.orange.shade900,
    ]),
    LColor(lmainColor: Colors.deepOrange, ldensityColors: [
      Colors.deepOrange.shade50,
      Colors.deepOrange.shade100,
      Colors.deepOrange.shade200,
      Colors.deepOrange.shade300,
      Colors.deepOrange.shade400,
      Colors.deepOrange.shade500,
      Colors.deepOrange.shade600,
      Colors.deepOrange.shade700,
      Colors.deepOrange.shade800,
      Colors.deepOrange.shade900,
    ]),
    LColor(lmainColor: Colors.brown, ldensityColors: [
      Colors.brown.shade50,
      Colors.brown.shade100,
      Colors.brown.shade200,
      Colors.brown.shade300,
      Colors.brown.shade400,
      Colors.brown.shade500,
      Colors.brown.shade600,
      Colors.brown.shade700,
      Colors.brown.shade800,
      Colors.brown.shade900,
    ]),
    LColor(lmainColor: Colors.grey, ldensityColors: [
      Colors.grey.shade50,
      Colors.grey.shade100,
      Colors.grey.shade200,
      Colors.grey.shade300,
      Colors.grey.shade400,
      Colors.grey.shade500,
      Colors.grey.shade600,
      Colors.grey.shade700,
      Colors.grey.shade800,
      Colors.grey.shade900,
    ]),
    LColor(lmainColor: Colors.blueGrey, ldensityColors: [
      Colors.blueGrey.shade50,
      Colors.blueGrey.shade100,
      Colors.blueGrey.shade200,
      Colors.blueGrey.shade300,
      Colors.blueGrey.shade400,
      Colors.blueGrey.shade500,
      Colors.blueGrey.shade600,
      Colors.blueGrey.shade700,
      Colors.blueGrey.shade800,
      Colors.blueGrey.shade900,
    ]),
  ];

  static const List<Map<String, dynamic>> countryList = [
    {
      "code": "OMR",
      "image": "assets/pngCountryImages/OMR.png",
      "country_name": "Omani Rial",
      "Symbol": "??.??."
    },
    {
      "code": "PAB",
      "image": "assets/pngCountryImages/PAB.png",
      "country_name": "Panamanian Balboa",
      "Symbol": "B/."
    },
    {
      "code": "AED",
      "image": "assets/pngCountryImages/AED.png",
      "country_name": "United Arab Emirates Dirham",
      "Symbol": "??.??"
    },
    {
      "code": "AFN",
      "image": "assets/pngCountryImages/AFN.png",
      "country_name": "Afghanistan ",
      "Symbol": "??"
    },
    {
      "code": "ALL",
      "image": "assets/pngCountryImages/ALL.png",
      "country_name": "Albanian Lek",
      "Symbol": "L"
    },
    {
      "code": "AMD",
      "image": "assets/pngCountryImages/AMD.png",
      "country_name": "Armenian Dram",
      "Symbol": "??"
    },
    {
      "code": "ANG",
      "image": "assets/pngCountryImages/ANG.png",
      "country_name": "Netherlands Antillean Guilder",
      "Symbol": "??"
    },
    {
      "code": "AOA",
      "image": "assets/pngCountryImages/AOA.png",
      "country_name": "Angolan Kwanza",
      "Symbol": "Kz"
    },
    {
      "code": "ARS",
      "image": "assets/pngCountryImages/ARS3.png",
      "country_name": "Argentine Peso",
      "Symbol": "\$"
    },
    {
      "code": "AUD",
      "image": "assets/pngCountryImages/AUD.png",
      "country_name": "Australian Dollar",
      "Symbol": "A\$"
    },
    {
      "code": "AWG",
      "image": "assets/pngCountryImages/AWG.png",
      "country_name": "Aruban Florin",
      "Symbol": "??"
    },
    {
      "code": "AZN",
      "image": "assets/pngCountryImages/AZN.png",
      "country_name": "AzerBaijani Manat",
      "Symbol": "AZN"
    },
    {
      "code": "BAM",
      "image": "assets/pngCountryImages/BAM.png",
      "country_name": "Bosnia Herzegovina Convertible Marka",
      "Symbol": "KM"
    },
    {
      "code": "BBD",
      "image": "assets/pngCountryImages/BBD.png",
      "country_name": "Barbadian Dollar",
      "Symbol": "Bds"
    },
    {
      "code": "BDT",
      "image": "assets/pngCountryImages/BDT.png",
      "country_name": "Bangladeshi Taka",
      "Symbol": "???"
    },
    {
      "code": "BGN",
      "image": "assets/pngCountryImages/BGN.png",
      "country_name": "Bulgarian Lev",
      "Symbol": "????"
    },
    {
      "code": "BHD",
      "image": "assets/pngCountryImages/BHD.png",
      "country_name": "Bahraini Dinar",
      "Symbol": "BD"
    },
    {
      "code": "BIF",
      "image": "assets/pngCountryImages/BIF.png",
      "country_name": "Burundian France",
      "Symbol": "FBu"
    },
    {
      "code": "BMD",
      "image": "assets/pngCountryImages/BMD.png",
      "country_name": "Bermudan Dollar",
      "Symbol": "\$"
    },
    {
      "code": "BND",
      "image": "assets/pngCountryImages/BND.png",
      "country_name": "Brunei Dollar",
      "Symbol": "B\$"
    },
    {
      "code": "BOB",
      "image": "assets/pngCountryImages/BOB.png",
      "country_name": "Bolivian Boliviano",
      "Symbol": "Bs."
    },
    {
      "code": "BRL",
      "image": "assets/pngCountryImages/BRL.png",
      "country_name": "Brazilian Real",
      "Symbol": "R\$"
    },
    {
      "code": "BSD",
      "image": "assets/pngCountryImages/BSD.png",
      "country_name": "Bahamian Dollar",
      "Symbol": "B\$"
    },
    {
      "code": "BTC",
      "image": "assets/pngCountryImages/BTC.png",
      "country_name": "Bitcoin",
      "Symbol": "???"
    },
    {
      "code": "BTN",
      "image": "assets/pngCountryImages/BTN.png",
      "country_name": "Bhutanese Ngultrum",
      "Symbol": "Nu."
    },
    {
      "code": "BWP",
      "image": "assets/pngCountryImages/BWP.png",
      "country_name": "Botsanan Pula",
      "Symbol": "P"
    },
    {
      "code": "BYN",
      "image": "assets/pngCountryImages/BYN.png",
      "country_name": "Belarusian Ruble",
      "Symbol": "BYN"
    },
    {
      "code": "BZD",
      "image": "assets/pngCountryImages/BZD.png",
      "country_name": "Belize Dollar",
      "Symbol": "\$"
    },
    {
      "code": "CAD",
      "image": "assets/pngCountryImages/CAD.png",
      "country_name": "Canadian Dollar",
      "Symbol": "Can\$"
    },
    {
      "code": "CDF",
      "image": "assets/pngCountryImages/CDF.png",
      "country_name": "Congolese Franc",
      "Symbol": "FC"
    },
    {
      "code": "CHF",
      "image": "assets/pngCountryImages/CHF.png",
      "country_name": "Swiss Franc",
      "Symbol": "SFr."
    },
    {
      "code": "SAR",
      "image": "assets/pngCountryImages/SAR.png",
      "country_name": "Saudi Riyal",
      "Symbol": "SR"
    },
    {
      "code": "CLP",
      "image": "assets/pngCountryImages/CLP.png",
      "country_name": "Chilean Peso",
      "Symbol": "\$"
    },
    {
      "code": "CNY",
      "image": "assets/pngCountryImages/CNY.png",
      "country_name": "Chinese Yuan",
      "Symbol": "??"
    },
    {
      "code": "COP",
      "image": "assets/pngCountryImages/COP.png",
      "country_name": "Colombian Peso",
      "Symbol": "\$"
    },
    {
      "code": "CRC",
      "image": "assets/pngCountryImages/CRC.png",
      "country_name": "Costa Rican Colon",
      "Symbol": "???"
    },
    {
      "code": "CUP",
      "image": "assets/pngCountryImages/CUP.png",
      "country_name": "Cuban Peso",
      "Symbol": "???"
    },
    {
      "code": "CVE",
      "image": "assets/pngCountryImages/CVE.png",
      "country_name": "Cape Verdean Escudo",
      "Symbol": "Esc"
    },
    {
      "code": "CZK",
      "image": "assets/pngCountryImages/CZK.png",
      "country_name": "Czech Republic Koruna",
      "Symbol": "K??"
    },
    {
      "code": "CLF",
      "image": "assets/pngCountryImages/CLF.png",
      "country_name": "Unidad de Fomento",
      "Symbol": "UF"
    },
    {
      "code": "CNH",
      "image": "assets/pngCountryImages/CNH.png",
      "country_name": "Renminbi",
      "Symbol": "??."
    },
    {
      "code": "CVC",
      "image": "assets/pngCountryImages/CVC.png",
      "country_name": "Cabo Verde Escudoa",
      "Symbol": ""
    },
    {
      "code": "CUC",
      "image": "assets/pngCountryImages/CUC.png",
      "country_name": "Cuban Convertible Peso",
      "Symbol": "CUC\$"
    },
    {
      "code": "DJF",
      "image": "assets/pngCountryImages/DJF.png",
      "country_name": "Djiboutian Franc",
      "Symbol": "Fdj"
    },
    {
      "code": "DKK",
      "image": "assets/pngCountryImages/DKK.png",
      "country_name": "Danish Krone",
      "Symbol": "Kr."
    },
    {
      "code": "DOP",
      "image": "assets/pngCountryImages/DOP.png",
      "country_name": "Dominican Peso",
      "Symbol": " RD\$"
    },
    {
      "code": "DZD",
      "image": "assets/pngCountryImages/DZD.png",
      "country_name": "Algerian Dinar",
      "Symbol": "????"
    },
    {
      "code": "EGP",
      "image": "assets/pngCountryImages/EGP.png",
      "country_name": "Egyptian Pound",
      "Symbol": "??.??"
    },
    {
      "code": "ERN",
      "image": "assets/pngCountryImages/ERN.png",
      "country_name": "Eritrean Nakfa",
      "Symbol": " ?????????"
    },
    {
      "code": "ETB",
      "image": "assets/pngCountryImages/ETB.png",
      "country_name": "Ethiopian Birr",
      "Symbol": "??????"
    },
    {
      "code": "EUR",
      "image": "assets/pngCountryImages/EUR.png",
      "country_name": " Euro",
      "Symbol": "???"
    },
    {
      "code": "FJD",
      "image": "assets/pngCountryImages/FJD.png",
      "country_name": "Fijian Dollar",
      "Symbol": "FJ\$"
    },
    {
      "code": "FKP",
      "image": "assets/pngCountryImages/FKP1.png",
      "country_name": "Falkland Islands Pound",
      "Symbol": "??"
    },
    {
      "code": "GBP",
      "image": "assets/pngCountryImages/GBP.png",
      "country_name": "British Pound Sterling",
      "Symbol": "??"
    },
    {
      "code": "GEL",
      "image": "assets/pngCountryImages/GEL.png",
      "country_name": " Geogian Lari ",
      "Symbol": "???"
    },
    {
      "code": "GHS",
      "image": "assets/pngCountryImages/GHS.png",
      "country_name": " Ghanaian Cedi ",
      "Symbol": " GH???"
    },
    {
      "code": "GIP",
      "image": "assets/pngCountryImages/GIP.png",
      "country_name": "Gibraltar Pround",
      "Symbol": "??"
    },
    {
      "code": "GGP",
      "image": "assets/pngCountryImages/GGP.png",
      "country_name": "	Guernsey Pound ",
      "Symbol": "??"
    },
    {
      "code": "GMD",
      "image": "assets/pngCountryImages/GMD.png",
      "country_name": "Gambian Dalasi",
      "Symbol": "D"
    },
    {
      "code": "GNF",
      "image": "assets/pngCountryImages/GNF.png",
      "country_name": "Guinean Franc",
      "Symbol": "GFr"
    },
    {
      "code": "GTQ",
      "image": "assets/pngCountryImages/GTQ.png",
      "country_name": "Guatemalan Quetzal ",
      "Symbol": "Q"
    },
    {
      "code": "GYD",
      "image": "assets/pngCountryImages/GYD.png",
      "country_name": "Guyanaese Dollar",
      "Symbol": " GY\$"
    },
    {
      "code": "HKD",
      "image": "assets/pngCountryImages/HKD.png",
      "country_name": "Hong Kong Dollar",
      "Symbol": "hk\$"
    },
    {
      "code": "HNL",
      "image": "assets/pngCountryImages/HNL.png",
      "country_name": "Honduran Lempira",
      "Symbol": "HK\$"
    },
    {
      "code": "HRK",
      "image": "assets/pngCountryImages/HRK.png",
      "country_name": "Croatian Kuna",
      "Symbol": "kn"
    },
    {
      "code": "HTG",
      "image": "assets/pngCountryImages/HTG.png",
      "country_name": "Haitian Gourda",
      "Symbol": "G"
    },
    {
      "code": "HUF",
      "image": "assets/pngCountryImages/HUF.png",
      "country_name": "Hungarian Forint",
      "Symbol": "Ft"
    },
    {
      "code": "IDR",
      "image": "assets/pngCountryImages/IDR.png",
      "country_name": "Indonesian Rupiah",
      "Symbol": "Rp"
    },
    {
      "code": "ILS",
      "image": "assets/pngCountryImages/ILS.png",
      "country_name": "Israeli New Sheqel",
      "Symbol": "???"
    },
    {
      "code": "INR",
      "image": "assets/pngCountryImages/INR.png",
      "country_name": "Indian Rupee",
      "Symbol": "???"
    },
    {
      "code": "IQD",
      "image": "assets/pngCountryImages/IQD.png",
      "country_name": "Iraqi Dinar",
      "Symbol": "??.??"
    },
    {
      "code": "IRR",
      "image": "assets/pngCountryImages/IRR.png",
      "country_name": "Iranian Rial",
      "Symbol": "???"
    },
    {
      "code": "ISK",
      "image": "assets/pngCountryImages/ISK.png",
      "country_name": "Icelandic Krona",
      "Symbol": "??kr"
    },
    {
      "code": "IMP",
      "image": "assets/pngCountryImages/IMP.png",
      "country_name": "	Isle of Man Pound",
      "Symbol": "??"
    },
    {
      "code": "JMD",
      "image": "assets/pngCountryImages/JMD.png",
      "country_name": "Jamaican Dollar",
      "Symbol": "\$"
    },
    {
      "code": "JOD",
      "image": "assets/pngCountryImages/JOD.png",
      "country_name": "Jordanian Dinar",
      "Symbol": "??.??"
    },
    {
      "code": "JPY",
      "image": "assets/pngCountryImages/JPY.png",
      "country_name": "Japanese Yen",
      "Symbol": "???"
    },
    {
      "code": "JEP",
      "image": "assets/pngCountryImages/JEP.png",
      "country_name": "Jersey Pound",
      "Symbol": "??"
    },
    {
      "code": "KES",
      "image": "assets/pngCountryImages/KES.png",
      "country_name": "Ke	South Korean ",
      "Symbol": "Ksh"
    },
    {
      "code": "KGS",
      "image": "assets/pngCountryImages/KGS.png",
      "country_name": "Kyrgystani Som",
      "Symbol": "????"
    },
    {
      "code": "KHR",
      "image": "assets/pngCountryImages/KHR.png",
      "country_name": "Cambodian Rial",
      "Symbol": "???"
    },
    {
      "code": "KMF",
      "image": "assets/pngCountryImages/KMF.png",
      "country_name": "Comoraian Franc",
      "Symbol": "CF"
    },
    {
      "code": "KPW",
      "image": "assets/pngCountryImages/KPW.png",
      "country_name": "North Korean Won",
      "Symbol": "???"
    },
    {
      "code": "KWD",
      "image": "assets/pngCountryImages/KWD.png",
      "country_name": "Kuwaiti Dinar",
      "Symbol": "??.??"
    },
    {
      "code": "KYD",
      "image": "assets/pngCountryImages/KYD.png",
      "country_name": "Cayman Islands Dollar",
      "Symbol": "\$"
    },
    {
      "code": "KZT",
      "image": "assets/pngCountryImages/KZT.png",
      "country_name": "Kazakhstani Tenge",
      "Symbol": "???"
    },
    {
      "code": "KRW",
      "image": "assets/pngCountryImages/KRW.png",
      "country_name": "	South Korean Won",
      "Symbol": "???"
    },
    {
      "code": "LAK",
      "image": "assets/pngCountryImages/LAK.png",
      "country_name": "Laotian Kip",
      "Symbol": "???N"
    },
    {
      "code": "LBP",
      "image": "assets/pngCountryImages/LBP.png",
      "country_name": "Lebanese Pound",
      "Symbol": "??.??.???"
    },
    {
      "code": "LKR",
      "image": "assets/pngCountryImages/LKR.png",
      "country_name": "Shri Lankan Rupee ",
      "Symbol": " ??????"
    },
    {
      "code": "LRD",
      "image": "assets/pngCountryImages/LRD.png",
      "country_name": "Liberian Dollar",
      "Symbol": "L\$"
    },
    {
      "code": "LSL",
      "image": "assets/pngCountryImages/LSL.png",
      "country_name": "Lesotho Loti ",
      "Symbol": "M"
    },
    {
      "code": "LYD",
      "image": "assets/pngCountryImages/LYD.png",
      "country_name": "Libyan Dinar",
      "Symbol": "??.??"
    },
    {
      "code": "MAD",
      "image": "assets/pngCountryImages/MAD.png",
      "country_name": "Moroccan Dirham ",
      "Symbol": "MAD"
    },
    {
      "code": "MDL",
      "image": "assets/pngCountryImages/MDL.png",
      "country_name": "Moldovan Leu",
      "Symbol": "L"
    },
    {
      "code": "MGA",
      "image": "assets/pngCountryImages/MGA.png",
      "country_name": "Malagasy Ariary",
      "Symbol": "Ar"
    },
    {
      "code": "MKD",
      "image": "assets/pngCountryImages/MKD.png",
      "country_name": "Macedonian Denar",
      "Symbol": "??????"
    },
    {
      "code": "MMK",
      "image": "assets/pngCountryImages/MMK.png",
      "country_name": "Myanma Kyat",
      "Symbol": "K"
    },
    {
      "code": "MNT",
      "image": "assets/pngCountryImages/MNT.png",
      "country_name": "Mongolian Tugrik",
      "Symbol": "???"
    },
    {
      "code": "MOP",
      "image": "assets/pngCountryImages/MOP.png",
      "country_name": "Macanese Pataca",
      "Symbol": "MOP\$"
    },
    {
      "code": "MRO",
      "image": "assets/pngCountryImages/MRO.png",
      "country_name": "Mauritanian Ouguiya",
      "Symbol": "UM"
    },
    {
      "code": "MUR",
      "image": "assets/pngCountryImages/MUR.png",
      "country_name": "Maurtitian Rupee ",
      "Symbol": "???"
    },
    {
      "code": "MRU",
      "image": "assets/pngCountryImages/MRU.png",
      "country_name": "	Mauritanian Ouguiya ",
      "Symbol": "MRU"
    },
    {
      "code": "MVR",
      "image": "assets/pngCountryImages/MVR.png",
      "country_name": "Maldivian Rufiya",
      "Symbol": "MRf"
    },
    {
      "code": "MWK",
      "image": "assets/pngCountryImages/MWK.png",
      "country_name": "Malawian Kwacha",
      "Symbol": "MK"
    },
    {
      "code": "MXN",
      "image": "assets/pngCountryImages/MXN.png",
      "country_name": " Mexican Peso",
      "Symbol": "Mex\$"
    },
    {
      "code": "MYR",
      "image": "assets/pngCountryImages/MYR.png",
      "country_name": "  Malaysian Ringgit",
      "Symbol": "RM"
    },
    {
      "code": "MZN",
      "image": "assets/pngCountryImages/MZN.png",
      "country_name": "Mozambican Metical",
      "Symbol": "MT"
    },
    {
      "code": "NAD",
      "image": "assets/pngCountryImages/NAD.png",
      "country_name": "Namibian Dollar",
      "Symbol": "???"
    },
    {
      "code": "NGN",
      "image": "assets/pngCountryImages/NGN.png",
      "country_name": "Nigerian Naira",
      "Symbol": "???"
    },
    {
      "code": "NIO",
      "image": "assets/pngCountryImages/NIO.png",
      "country_name": "Nicaraguan Cordoba",
      "Symbol": "C\$"
    },
    {
      "code": "NOK",
      "image": "assets/pngCountryImages/NOK.png",
      "country_name": "Norwegian Krone",
      "Symbol": "kr"
    },
    {
      "code": "NPR",
      "image": "assets/pngCountryImages/NPR.png",
      "country_name": "Nepalese Rupee",
      "Symbol": "??????"
    },
    {
      "code": "NZD",
      "image": "assets/pngCountryImages/NZD.png",
      "country_name": "New Zealand Dollar",
      "Symbol": "\$"
    },
    {
      "code": "PEN",
      "image": "assets/pngCountryImages/PEN.png",
      "country_name": "Peruvian Nuevo Sol",
      "Symbol": "K"
    },
    {
      "code": "PGK",
      "image": "assets/pngCountryImages/PGK.png",
      "country_name": "Papua New Guinean Kina",
      "Symbol": "S/"
    },
    {
      "code": "PHP",
      "image": "assets/pngCountryImages/PHP.png",
      "country_name": "Philippine Rupee",
      "Symbol": "(???)"
    },
    {
      "code": "PKR",
      "image": "assets/pngCountryImages/PKR.png",
      "country_name": "Pakistani Rupee",
      "Symbol": "???"
    },
    {
      "code": "PLN",
      "image": "assets/pngCountryImages/PLN.png",
      "country_name": "Polish Zloty",
      "Symbol": "z??"
    },
    {
      "code": "PYG",
      "image": "assets/pngCountryImages/PYG.png",
      "country_name": "Paraguayan Guarani",
      "Symbol": "???"
    },
    {
      "code": "QAR",
      "image": "assets/pngCountryImages/QAR.png",
      "country_name": "Qatari Rial",
      "Symbol": "??.??"
    },
    {
      "code": "RON",
      "image": "assets/pngCountryImages/RON.png",
      "country_name": "Romanian leu",
      "Symbol": "lei"
    },
    {
      "code": "RSD",
      "image": "assets/pngCountryImages/RSD.png",
      "country_name": "Serbian Dinar",
      "Symbol": "din"
    },
    {
      "code": "RUB",
      "image": "assets/pngCountryImages/RUB.png",
      "country_name": "Russian Ruble",
      "Symbol": "???"
    },
    {
      "code": "RWF",
      "image": "assets/pngCountryImages/RWF.png",
      "country_name": "Rwandan Franc",
      "Symbol": "FRw"
    },
    {
      "code": "SBD",
      "image": "assets/pngCountryImages/SBD.png",
      "country_name": "Salomon Islands Dollar",
      "Symbol": "Si\$"
    },
    {
      "code": "SCR",
      "image": "assets/pngCountryImages/SCR.png",
      "country_name": "Seychellois Rupee",
      "Symbol": "??? /-"
    },
    {
      "code": "SDG",
      "image": "assets/pngCountryImages/SDG.png",
      "country_name": "Sudanese Pound",
      "Symbol": "??.??."
    },
    {
      "code": "SEK",
      "image": "assets/pngCountryImages/SEK.png",
      "country_name": "Swedish Krona ",
      "Symbol": "kr"
    },
    {
      "code": "SGD",
      "image": "assets/pngCountryImages/SGD.png",
      "country_name": "Singapore Dollar ",
      "Symbol": "S\$"
    },
    {
      "code": "SHP",
      "image": "assets/pngCountryImages/SHP.png",
      "country_name": "Saint Helena Pound",
      "Symbol": "??"
    },
    {
      "code": "SLL",
      "image": "assets/pngCountryImages/SLL.png",
      "country_name": "Sierra Leonean Leone",
      "Symbol": "Le"
    },
    {
      "code": "SOS",
      "image": "assets/pngCountryImages/SOS.png",
      "country_name": "Somali Shilling",
      "Symbol": "Sh.so."
    },
    {
      "code": "SRD",
      "image": "assets/pngCountryImages/SRD.png",
      "country_name": "Surinamese Dollar",
      "Symbol": "\$"
    },
    {
      "code": "SSP",
      "image": "assets/pngCountryImages/SSP.png",
      "country_name": "South Sudanese Pound",
      "Symbol": "??"
    },
    {
      "code": "STD",
      "image": "assets/pngCountryImages/STD.png",
      "country_name": "Sao Tomean Dobra",
      "Symbol": "Db"
    },
    {
      "code": "STN",
      "image": "assets/pngCountryImages/STN.png",
      "country_name": "S??o Tom?? and Pr??ncipe",
      "Symbol": "Db"
    },
    {
      "code": "SYP",
      "image": "assets/pngCountryImages/SYP.png",
      "country_name": "Syrian Pound",
      "Symbol": "??S "
    },
    {
      "code": "SZL",
      "image": "assets/pngCountryImages/SZL.png",
      "country_name": "Swazi Lilangebi",
      "Symbol": "L"
    },
    {
      "code": "SVC",
      "image": "assets/pngCountryImages/SVC.png",
      "country_name": "El Salvador Colon",
      "Symbol": "???"
    },
    {
      "code": "THB",
      "image": "assets/pngCountryImages/THB.png",
      "country_name": "Thai Baht",
      "Symbol": "???"
    },
    {
      "code": "TJS",
      "image": "assets/pngCountryImages/TJS.png",
      "country_name": "Tajikistani Somoni",
      "Symbol": "??M"
    },
    {
      "code": "TMT",
      "image": "assets/pngCountryImages/TMT.png",
      "country_name": "Turkmenistani Manat",
      "Symbol": "T"
    },
    {
      "code": "TND",
      "image": "assets/pngCountryImages/TND.png",
      "country_name": "Tunisian Dinar",
      "Symbol": " ??.?? "
    },
    {
      "code": "TOP",
      "image": "assets/pngCountryImages/TOP.png",
      "country_name": "Tongan Pa'anga",
      "Symbol": "T\$"
    },
    {
      "code": "TRY",
      "image": "assets/pngCountryImages/TRY.png",
      "country_name": "Turkish Lira",
      "Symbol": "???"
    },
    {
      "code": "TTD",
      "image": "assets/pngCountryImages/TTD.png",
      "country_name": "Trinidad and Tobago ",
      "Symbol": "TT??"
    },
    {
      "code": "TWD",
      "image": "assets/pngCountryImages/TWD.png",
      "country_name": "New Taiwan Dollar",
      "Symbol": "NT\$"
    },
    {
      "code": "TZS",
      "image": "assets/pngCountryImages/TZS.png",
      "country_name": "Tanzanian Shilling",
      "Symbol": "TSh"
    },
    {
      "code": "UAH",
      "image": "assets/pngCountryImages/UAH.png",
      "country_name": "Ukrainian Hryvnia",
      "Symbol": "???"
    },
    {
      "code": "UGX",
      "image": "assets/pngCountryImages/UGX.png",
      "country_name": "Ugandan Shilling",
      "Symbol": "USh"
    },
    {
      "code": "USD",
      "image": "assets/pngCountryImages/USD.png",
      "country_name": "United States Dollar",
      "Symbol": "\$"
    },
    {
      "code": "UYU",
      "image": "assets/pngCountryImages/UYU.png",
      "country_name": "Uruguayan Peso",
      "Symbol": "\$U"
    },
    {
      "code": "UZS",
      "image": "assets/pngCountryImages/UZS.png",
      "country_name": "Uzbekistan Som",
      "Symbol": "so'm"
    },
    {
      "code": "VES",
      "image": "assets/pngCountryImages/VES.png",
      "country_name": "Venezuelan Bolivar Fuerte",
      "Symbol": "Bs"
    },
    {
      "code": "VND",
      "image": "assets/pngCountryImages/VND.png",
      "country_name": "Vietnamese Dong",
      "Symbol": "???"
    },
    {
      "code": "VUV",
      "image": "assets/pngCountryImages/VUV.png",
      "country_name": "Vanuatu Vatu ",
      "Symbol": "VT"
    },
    {
      "code": "WST",
      "image": "assets/pngCountryImages/WST.png",
      "country_name": "Samoan Tala ",
      "Symbol": "SAT"
    },
    {
      "code": "XAF",
      "image": "assets/pngCountryImages/XAF.png",
      "country_name": "CFA Franc BEAC ",
      "Symbol": "FCFA"
    },
    {
      "code": "XCD",
      "image": "assets/pngCountryImages/XCD.png",
      "country_name": "East Caribbean Dollar",
      "Symbol": "\$"
    },
    {
      "code": "XOF",
      "image": "assets/pngCountryImages/XOF.png",
      "country_name": "CFA Franc BCEAO ",
      "Symbol": "CFA"
    },
    {
      "code": "XAG",
      "image": "assets/pngCountryImages/XAG.png",
      "country_name": "Swazi Lilangebi",
      "Symbol": "E"
    },
    {
      "code": "XAU",
      "image": "assets/pngCountryImages/XAU.png",
      "country_name": "Vietnam Dong",
      "Symbol": "???"
    },
    {
      "code": "XDR",
      "image": "assets/pngCountryImages/XDR.png",
      "country_name": "Special Drawing Rights",
      "Symbol": "SDR"
    },
    {
      "code": "XPD",
      "image": "assets/pngCountryImages/XPD.png",
      "country_name": "Ounce of palladium",
      "Symbol": "XPD"
    },
    {
      "code": "XPT",
      "image": "assets/pngCountryImages/XPT.png",
      "country_name": "Ounce of platinum",
      "Symbol": "oz"
    },
    {
      "code": "XPF",
      "image": "assets/pngCountryImages/XPF.png",
      "country_name": "CFP Franc",
      "Symbol": "Fr."
    },
    {
      "code": "YER",
      "image": "assets/pngCountryImages/YER.png",
      "country_name": "Yemeni Rial",
      "Symbol": "???"
    },
    {
      "code": "ZAR",
      "image": "assets/pngCountryImages/ZAR.png",
      "country_name": "south African Rand",
      "Symbol": "ZR"
    },
    {
      "code": "ZWL",
      "image": "assets/pngCountryImages/ZWL.png",
      "country_name": "Zimbabwean dollar",
      "Symbol": "Z\$"
    },
    {
      "code": "ZMW",
      "image": "assets/pngCountryImages/ZMW.png",
      "country_name": "Zambia",
      "Symbol": "ZK"
    }
  ];
}
