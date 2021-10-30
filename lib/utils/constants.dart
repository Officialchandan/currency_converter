import 'dart:ui';

class Constants {
  static const String currencyCodeFrom = "currencyCodeFrom";
  static const String currencyCodeTo = "currencyCodeTo";
  static const String themeColor = "theme";
  static const String currencySaveData = "currencysavedata";
  static const String monetaryFormat = "monetaryFormat";
  static const String decimalFormat = "decimalFormat";


  static const List<Map<String, dynamic>> countryList = [

    {
      "code": "OMR",
      "image": "assets/pngCountryImages/OMR.png",
      "country_name": "Omani Rial",
      "Symbol": "ر.ع."
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
      "country_name": "United Arab Emirates",
      "Symbol": "د.إ"
    },
    {
      "code": "AFN",
      "image": "assets/pngCountryImages/AFN.png",
      "country_name": "Afghanistan ",
      "Symbol": "؋"
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
      "Symbol": "Դ"
    },
    {
      "code": "ANG",
      "image": "assets/pngCountryImages/ANG.png",
      "country_name": "Netherlands Antillean Guilder",
      "Symbol": "ƒ"
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
      "Symbol": "ƒ"
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
      "country_name": "Bosnia-Herzegovina Convertible Marka",
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
      "Symbol": "৳"
    },
    {
      "code": "BGN",
      "image": "assets/pngCountryImages/BGN.png",
      "country_name": "Bulgarian Lev",
      "Symbol": "Лв"
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
      "Symbol": "₿"
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
    {"code":"SAR", "image":"assets/pngCountryImages/SAR.png", "country_name":"Saudi Riyal","Symbol": "SR"},
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
      "Symbol": "¥"
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
      "Symbol": "₡"
    },
    {
      "code": "CUP",
      "image": "assets/pngCountryImages/CUP.png",
      "country_name": "Cuban Peso",
      "Symbol": "₱"
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
      "Symbol": "Kč"
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
      "Symbol": "¥."
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
      "Symbol": "دج"
    },
    {
      "code": "EGP",
      "image": "assets/pngCountryImages/EGP.png",
      "country_name": "Egyptian Pound",
      "Symbol": "ج.م"
    },
    {
      "code": "ERN",
      "image": "assets/pngCountryImages/ERN.png",
      "country_name": "Eritrean Nakfa",
      "Symbol": " ናቕፋ"
    },
    {
      "code": "ETB",
      "image": "assets/pngCountryImages/ETB.png",
      "country_name": "Ethiopian Birr",
      "Symbol": "ብር"
    },
    {
      "code": "EUR",
      "image": "assets/pngCountryImages/EUR.png",
      "country_name": " Euro",
      "Symbol": "€"
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
      "Symbol": "£"
    },
    {
      "code": "GBP",
      "image": "assets/pngCountryImages/GBP.png",
      "country_name": "British Pound Sterling",
      "Symbol": "£"
    },
    {
      "code": "GEL",
      "image": "assets/pngCountryImages/GEL.png",
      "country_name": " Geogian Lari ",
      "Symbol": "ლ"
    },
    {
      "code": "GHS",
      "image": "assets/pngCountryImages/GHS.png",
      "country_name": " Ghanaian Cedi ",
      "Symbol": " GH₵"
    },
    {
      "code": "GIP",
      "image": "assets/pngCountryImages/GIP.png",
      "country_name": "Gibraltar Pround",
      "Symbol": "£"
    },
    {
      "code": "GGP",
      "image": "assets/pngCountryImages/GGP.png",
      "country_name": "	Guernsey Pound ",
      "Symbol": "£"
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
      "Symbol": "₪"
    },
    {
      "code": "INR",
      "image": "assets/pngCountryImages/INR.png",
      "country_name": "Indian Rupee",
      "Symbol": "₹"
    },
    {
      "code": "IQD",
      "image": "assets/pngCountryImages/IQD.png",
      "country_name": "Iraqi Dinar",
      "Symbol": "ع.د"
    },
    {
      "code": "IRR",
      "image": "assets/pngCountryImages/IRR.png",
      "country_name": "Iranian Rial",
      "Symbol": "﷼"
    },
    {
      "code": "ISK",
      "image": "assets/pngCountryImages/ISK.png",
      "country_name": "Icelandic Krona",
      "Symbol": "Íkr"
    },
    {
      "code": "IMP",
      "image": "assets/pngCountryImages/IMP.png",
      "country_name": "	Isle of Man Pound",
      "Symbol": "£"
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
      "Symbol": "د.ا"
    },
    {
      "code": "JPY",
      "image": "assets/pngCountryImages/JPY.png",
      "country_name": "Japanese Yen",
      "Symbol": "圓"
    },
    {
      "code": "JEP",
      "image": "assets/pngCountryImages/JEP.png",
      "country_name": "Jersey Pound",
      "Symbol": "£"
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
      "Symbol": "Лв"
    },
    {
      "code": "KHR",
      "image": "assets/pngCountryImages/KHR.png",
      "country_name": "Cambodian Rial",
      "Symbol": "៛"
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
      "Symbol": "₩"
    },
    {
      "code": "KWD",
      "image": "assets/pngCountryImages/KWD.png",
      "country_name": "Kuwaiti Dinar",
      "Symbol": "د.ك"
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
      "Symbol": "₸"
    },
    {
      "code": "KRW",
      "image": "assets/pngCountryImages/KRW.png",
      "country_name": "	South Korean Won",
      "Symbol": "₩"
    },
    {
      "code": "LAK",
      "image": "assets/pngCountryImages/LAK.png",
      "country_name": "Laotian Kip",
      "Symbol": "₭N"
    },
    {
      "code": "LBP",
      "image": "assets/pngCountryImages/LBP.png",
      "country_name": "Lebanese Pound",
      "Symbol": "ل.ل.‎"
    },
    {
      "code": "LKR",
      "image": "assets/pngCountryImages/LKR.png",
      "country_name": "Shri Lankan Rupee ",
      "Symbol": " රු"
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
      "Symbol": "ل.د"
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
      "Symbol": "Ден"
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
      "Symbol": "₮"
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
      "Symbol": "₨"
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
      "Symbol": "€"
    },
    {
      "code": "NGN",
      "image": "assets/pngCountryImages/NGN.png",
      "country_name": "Nigerian Naira",
      "Symbol": "₦"
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
      "Symbol": "रू"
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
      "Symbol": "(₱)"
    },
    {
      "code": "PKR",
      "image": "assets/pngCountryImages/PKR.png",
      "country_name": "Pakistani Rupee",
      "Symbol": "₨"
    },
    {
      "code": "PLN",
      "image": "assets/pngCountryImages/PLN.png",
      "country_name": "Polish Zloty",
      "Symbol": "zł"
    },
    {
      "code": "PYG",
      "image": "assets/pngCountryImages/PYG.png",
      "country_name": "Paraguayan Guarani",
      "Symbol": "₲"
    },
    {
      "code": "QAR",
      "image": "assets/pngCountryImages/QAR.png",
      "country_name": "Qatari Rial",
      "Symbol": "ر.ق"
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
      "Symbol": "₽"
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
      "Symbol": "₨ /-"
    },
    {
      "code": "SDG",
      "image": "assets/pngCountryImages/SDG.png",
      "country_name": "Sudanese Pound",
      "Symbol": "ج.س."
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
      "Symbol": "£"
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
      "Symbol": "£"
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
      "country_name": "São Tomé and Príncipe",
      "Symbol": "Db"
    },
    {
      "code": "SYP",
      "image": "assets/pngCountryImages/SYP.png",
      "country_name": "Syrian Pound",
      "Symbol": "£S "
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
      "Symbol": "₡"
    },
    {
      "code": "THB",
      "image": "assets/pngCountryImages/THB.png",
      "country_name": "Thai Baht",
      "Symbol": "฿"
    },
    {
      "code": "TJS",
      "image": "assets/pngCountryImages/TJS.png",
      "country_name": "Tajikistani Somoni",
      "Symbol": "ЅM"
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
      "Symbol": " د.ت "
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
      "Symbol": "₺"
    },
    {
      "code": "TTD",
      "image": "assets/pngCountryImages/TTD.png",
      "country_name": "Trinidad and Tobago ",
      "Symbol": "TT¢"
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
      "Symbol": "₴"
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
      "Symbol": "₫"
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
      "Symbol": "₫"
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
      "Symbol": "﷼"
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
