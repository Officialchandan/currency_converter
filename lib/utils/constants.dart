import 'dart:ui';

class Constants {
  static const String currencyCodeFrom = "currencyCodeFrom";
  static const String currencyCodeTo = "currencyCodeTo";
  static const String themeColor = "theme";

  static const String currencySaveData = "currencysavedata";

  static const List<Map<String, dynamic>> countryList = [
    // {
    //   "code": "AED",
    //   "image": "assets/countyImage/AED.svg",
    //   "country_name": "United Arab Emirates Dirha..",
    //   "Symbol": "د.إ"
    // },
    // {
    //   "code": "AFN",
    //   "image": "assets/countyImage/AFN.svg",
    //   "country_name": "Ffghan Ffghani ",
    //   "Symbol": "؋"
    // },
    // {
    //   "code": "ALL",
    //   "image": "assets/countyImage/ALL.svg",
    //   "country_name": "Albanian Lek",
    //   "Symbol": "L"
    // },
    // {
    //   "code": "AMD",
    //   "image": "assets/countyImage/AMD.svg",
    //   "country_name": "Armenian Dram",
    //   "Symbol": "Դ"
    // },
    // {
    //   "code": "ANG",
    //   "image": "assets/countyImage/ANG.svg",
    //   "country_name": "Netherlands Antillean Guil..",
    //   "Symbol": "ƒ"
    // },
    // {
    //   "code": "AOA",
    //   "image": "assets/countyImage/AOA.svg",
    //   "country_name": "Angolan Kwanza",
    //   "Symbol": "Kz"
    // },
    // {
    //   "code": "ARS",
    //   "image": "assets/countyImage/ARS.svg",
    //   "country_name": "Argentine Peso",
    //   "Symbol": "\$"
    // },
    // {
    //   "code": "AUD",
    //   "image": "assets/countyImage/AUD.svg",
    //   "country_name": "Australian Dollar",
    //   "Symbol": "A\$"
    // },
    // {
    //   "code": "AWG",
    //   "image": "assets/countyImage/AWG.svg",
    //   "country_name": "Aruban Florin",
    //   "Symbol": "ƒ"
    // },
    // {
    //   "code": "AZN",
    //   "image": "assets/countyImage/AZN.svg",
    //   "country_name": "AzerBaijani Manat",
    //   "Symbol": "AZN"
    // },
    // {
    //   "code": "BAM",
    //   "image": "assets/countyImage/BAM.svg",
    //   "country_name": "Bosnia-Herzegovina Conve..",
    //   "Symbol": ""
    // },
    // {
    //   "code": "BBD",
    //   "image": "assets/countyImage/BBD.svg",
    //   "country_name": "Barbadian Dollar",
    //   "Symbol": ""
    // },
    // {
    //   "code": "BDT",
    //   "image": "assets/countyImage/BDT.svg",
    //   "country_name": "Bangladeshi Taka",
    //   "Symbol": "৳"
    // },
    // {
    //   "code": "BGN",
    //   "image": "assets/countyImage/BGN.svg",
    //   "country_name": "Bulgarian Lev",
    //   "Symbol": "Лв"
    // },
    // {
    //   "code": "BHD",
    //   "image": "assets/countyImage/BHD.svg",
    //   "country_name": "Bahraini Dinar",
    //   "Symbol": "BD"
    // },
    // {
    //   "code": "BIF",
    //   "image": "assets/countyImage/BIF.svg",
    //   "country_name": "Burundian France",
    //   "Symbol": ""
    // },
    // {
    //   "code": "BMD",
    //   "image": "assets/countyImage/BMD.svg",
    //   "country_name": "Bermudan Dollar",
    //   "Symbol": "\$"
    // },
    // {
    //   "code": "BND",
    //   "image": "assets/countyImage/BND.svg",
    //   "country_name": "Brunei Dollar",
    //   "Symbol": "B\$"
    // },
    // {
    //   "code": "BOB",
    //   "image": "assets/countyImage/BOB.svg",
    //   "country_name": "Bolivian Boliviano",
    //   "Symbol": "Bs."
    // },
    // {
    //   "code": "BRL",
    //   "image": "assets/countyImage/BRL.svg",
    //   "country_name": "Brazilian Real",
    //   "Symbol": "R\$"
    // },
    // {
    //   "code": "BSD",
    //   "image": "assets/countyImage/BSD.svg",
    //   "country_name": "Bahamian Dollar",
    //   "Symbol": "B\$"
    // },
    // {
    //   "code": "BTC",
    //   "image": "assets/countyImage/BTC.svg",
    //   "country_name": "Bitcoin",
    //   "Symbol": "₿"
    // },
    // {
    //   "code": "BTN",
    //   "image": "assets/countyImage/BTN.svg",
    //   "country_name": "Bhutanese Ngultrum",
    //   "Symbol": "Nu."
    // },
    // {
    //   "code": "BWP",
    //   "image": "assets/countyImage/BWP.svg",
    //   "country_name": "Botsanan Pula",
    //   "Symbol": "P"
    // },
    // {
    //   "code": "BYN",
    //   "image": "assets/countyImage/BYN.svg",
    //   "country_name": "Belarusian Ruble",
    //   "Symbol": "BYN"
    // },
    // {
    //   "code": "BZD",
    //   "image": "assets/countyImage/BZD.svg",
    //   "country_name": "Belize Dollar",
    //   "Symbol": "\$"
    // },
    // {
    //   "code": "CAD",
    //   "image": "assets/countyImage/CAD.svg",
    //   "country_name": "Canadian Dollar",
    //   "Symbol": "Can\$"
    // },
    // {
    //   "code": "CDF",
    //   "image": "assets/countyImage/CDF.svg",
    //   "country_name": "Congolese Franc",
    //   "Symbol": "FC"
    // },
    // {
    //   "code": "CHF",
    //   "image": "assets/countyImage/CHF.svg",
    //   "country_name": "Swiss Franc",
    //   "Symbol": "SFr."
    // },
    // {
    //   "code": "CLP",
    //   "image": "assets/countyImage/CLP.svg",
    //   "country_name": "Chilean Peso",
    //   "Symbol": "\$"
    // },
    // {
    //   "code": "CNY",
    //   "image": "assets/countyImage/CNY.svg",
    //   "country_name": "Chinese Yuan",
    //   "Symbol": "¥"
    // },
    // {
    //   "code": "COP",
    //   "image": "assets/countyImage/COP.svg",
    //   "country_name": "Colombian Peso",
    //   "Symbol": "\$"
    // },
    // {
    //   "code": "CRC",
    //   "image": "assets/countyImage/CRC.svg",
    //   "country_name": "Costa Rican Colon",
    //   "Symbol": "₡"
    // },
    // {
    //   "code": "CUP",
    //   "image": "assets/countyImage/CUP.svg",
    //   "country_name": "Cuban Peso",
    //   "Symbol": "₱"
    // },
    // {
    //   "code": "CVE",
    //   "image": "assets/countyImage/CVE.svg",
    //   "country_name": "Cape Verdean Escudo",
    //   "Symbol": "Esc"
    // },
    // {
    //   "code": "CZK",
    //   "image": "assets/countyImage/CZK.svg",
    //   "country_name": "Czech Republic Koruna",
    //   "Symbol": "Kč"
    // },
    // {
    //   "code": "CLF",
    //   "image": "assets/countyImage/CLF.svg",
    //   "country_name": "Unidad de Fomento",
    //   "Symbol": "UF"
    // },
    // {
    //   "code": "CNH",
    //   "image": "assets/countyImage/CNH.svg",
    //   "country_name": "Renminbi",
    //   "Symbol": "¥."
    // },
    // {
    //   "code": "CVC",
    //   "image": "assets/countyImage/CVC.svg",
    //   "country_name": "Cabo Verde Escudoa",
    //   "Symbol": ""
    // },
    // {
    //   "code": "CUC",
    //   "image": "assets/countyImage/CUC.svg",
    //   "country_name": "Cuban Convertible Peso",
    //   "Symbol": "CUC\$"
    // },
    // {
    //   "code": "DJF",
    //   "image": "assets/countyImage/DJF.svg",
    //   "country_name": "Djiboutian Franc",
    //   "Symbol": "Fdj"
    // },
    // {
    //   "code": "DKK",
    //   "image": "assets/countyImage/DKK.svg",
    //   "country_name": "Danish Krone",
    //   "Symbol": "Kr."
    // },
    // {
    //   "code": "DOP",
    //   "image": "assets/countyImage/DOP.svg",
    //   "country_name": "Dominican Peso",
    //   "Symbol": " RD\$"
    // },
    // {
    //   "code": "DZD",
    //   "image": "assets/countyImage/DZD.svg",
    //   "country_name": "Algerian Dinar",
    //   "Symbol": "دج"
    // },
    // {
    //   "code": "EGP",
    //   "image": "assets/countyImage/EGP.svg",
    //   "country_name": "Egyptian Pound",
    //   "Symbol": "ج.م"
    // },
    // {
    //   "code": "ERN",
    //   "image": "assets/countyImage/ERN.svg",
    //   "country_name": "Eritrean Nakfa",
    //   "Symbol": " ናቕፋ"
    // },
    // {
    //   "code": "ETB",
    //   "image": "assets/countyImage/ETB.svg",
    //   "country_name": "Ethiopian Birr",
    //   "Symbol": "ብር"
    // },
    // {
    //   "code": "EUR",
    //   "image": "assets/countyImage/EUR.svg",
    //   "country_name": " Euro",
    //   "Symbol": "€"
    // },
    // {
    //   "code": "FJD",
    //   "image": "assets/countyImage/FJD.svg",
    //   "country_name": "Fijian Dollar",
    //   "Symbol": "FJ\$"
    // },
    // {
    //   "code": "FKP",
    //   "image": "assets/countyImage/FKP.svg",
    //   "country_name": "Falkland Islands Pound",
    //   "Symbol": "£"
    // },
    // {
    //   "code": "GBP",
    //   "image": "assets/countyImage/GBP.svg",
    //   "country_name": "British Pound Sterling",
    //   "Symbol": "£"
    // },
    // {
    //   "code": "GEL",
    //   "image": "assets/countyImage/GEL.svg",
    //   "country_name": " Geogian Lari ",
    //   "Symbol": "ლ"
    // },
    // {
    //   "code": "GHS",
    //   "image": "assets/countyImage/GHS.svg",
    //   "country_name": " Ghanaian Cedi ",
    //   "Symbol": " GH₵"
    // },
    // {
    //   "code": "GIP",
    //   "image": "assets/countyImage/GIP.svg",
    //   "country_name": "Gibraltar Pround",
    //   "Symbol": "£"
    // },
    // {
    //   "code": "GGP",
    //   "image": "assets/countyImage/GGP.svg",
    //   "country_name": "	Guernsey Pound ",
    //   "Symbol": "£"
    // },
    // {
    //   "code": "GMD",
    //   "image": "assets/countyImage/GMD.svg",
    //   "country_name": "Gambian Dalasi",
    //   "Symbol": "D"
    // },
    // {
    //   "code": "GNF",
    //   "image": "assets/countyImage/GNF.svg",
    //   "country_name": "Guinean Franc",
    //   "Symbol": "GFr"
    // },
    // {
    //   "code": "GTQ",
    //   "image": "assets/countyImage/GTQ.svg",
    //   "country_name": "Guatemalan Quetzal ",
    //   "Symbol": "Q"
    // },
    // {
    //   "code": "GYD",
    //   "image": "assets/countyImage/GYD.svg",
    //   "country_name": "Guyanaese Dollar",
    //   "Symbol": " GY\$"
    // },
    // {
    //   "code": "HKD",
    //   "image": "assets/countyImage/HKD.svg",
    //   "country_name": "Hong Kong Dollar",
    //   "Symbol": ""
    // },
    // {
    //   "code": "HNL",
    //   "image": "assets/countyImage/HNL.svg",
    //   "country_name": "Honduran Lempira",
    //   "Symbol": "HK\$"
    // },
    // {
    //   "code": "HRK",
    //   "image": "assets/countyImage/HRK.svg",
    //   "country_name": "Croatian Kuna",
    //   "Symbol": "kn"
    // },
    // {
    //   "code": "HTG",
    //   "image": "assets/countyImage/HTG.svg",
    //   "country_name": "Haitian Gourda",
    //   "Symbol": "G"
    // },
    // {
    //   "code": "HUF",
    //   "image": "assets/countyImage/HUF.svg",
    //   "country_name": "Hungarian Forint",
    //   "Symbol": "Ft"
    // },
    // {
    //   "code": "IDR",
    //   "image": "assets/countyImage/IDR.svg",
    //   "country_name": "Indonesian Rupiah",
    //   "Symbol": "Rp"
    // },
    // {
    //   "code": "ILS",
    //   "image": "assets/countyImage/ILS.svg",
    //   "country_name": "Israeli New Sheqel",
    //   "Symbol": "₪"
    // },
    // {
    //   "code": "INR",
    //   "image": "assets/countyImage/INR.svg",
    //   "country_name": "Indian Rupee",
    //   "Symbol": "₹"
    // },
    // {
    //   "code": "IQD",
    //   "image": "assets/countyImage/IQD.svg",
    //   "country_name": "Iraqi Dinar",
    //   "Symbol": "ع.د"
    // },
    // {
    //   "code": "IRR",
    //   "image": "assets/countyImage/IRR.svg",
    //   "country_name": "Iranian Rial",
    //   "Symbol": "﷼"
    // },
    // {
    //   "code": "ISK",
    //   "image": "assets/countyImage/ISK.svg",
    //   "country_name": "Icelandic Krona",
    //   "Symbol": "Íkr"
    // },
    // {
    //   "code": "IMP",
    //   "image": "assets/countyImage/IMP.svg",
    //   "country_name": "	Isle of Man Pound",
    //   "Symbol": "£"
    // },
    // {
    //   "code": "JMD",
    //   "image": "assets/countyImage/JMD.svg",
    //   "country_name": "Jamaican Dollar",
    //   "Symbol": "\$"
    // },
    // {
    //   "code": "JOD",
    //   "image": "assets/countyImage/JOD.svg",
    //   "country_name": "Jordanian Dinar",
    //   "Symbol": "د.ا"
    // },
    // {
    //   "code": "JPY",
    //   "image": "assets/countyImage/JPY.svg",
    //   "country_name": "Japanese Yen",
    //   "Symbol": "圓"
    // },
    // {
    //   "code": "JEP",
    //   "image": "assets/countyImage/JEP.svg",
    //   "country_name": "Jersey Pound",
    //   "Symbol": "£"
    // },
    // {
    //   "code": "KES",
    //   "image": "assets/countyImage/KES.svg",
    //   "country_name": "Ke	South Korean ..",
    //   "Symbol": "Ksh"
    // },
    // {
    //   "code": "KGS",
    //   "image": "assets/countyImage/KGS.svg",
    //   "country_name": "Kyrgystani Som",
    //   "Symbol": "Лв"
    // },
    // {
    //   "code": "KHR",
    //   "image": "assets/countyImage/KHR.svg",
    //   "country_name": "Cambodian Rial",
    //   "Symbol": "៛"
    // },
    // {
    //   "code": "KMF",
    //   "image": "assets/countyImage/KMF.svg",
    //   "country_name": "Comoraian Franc",
    //   "Symbol": "CF"
    // },
    // {
    //   "code": "KPW",
    //   "image": "assets/countyImage/KPW.svg",
    //   "country_name": "North Korean Won",
    //   "Symbol": "₩"
    // },
    // {
    //   "code": "KWD",
    //   "image": "assets/countyImage/KWD.svg",
    //   "country_name": "Kuwaiti Dinar",
    //   "Symbol": "د.ك"
    // },
    // {
    //   "code": "KYD",
    //   "image": "assets/countyImage/KYD.svg",
    //   "country_name": "Cayman Islands Dollar",
    //   "Symbol": "\$"
    // },
    // {
    //   "code": "KZT",
    //   "image": "assets/countyImage/KZT.svg",
    //   "country_name": "Kazakhstani Tenge",
    //   "Symbol": "₸"
    // },
    // {
    //   "code": "KRW",
    //   "image": "assets/countyImage/KRW.svg",
    //   "country_name": "	South Korean Won",
    //   "Symbol": "₩"
    // },
    // {
    //   "code": "LAK",
    //   "image": "assets/countyImage/LAK.svg",
    //   "country_name": "Laotian Kip",
    //   "Symbol": "₭N"
    // },
    // {
    //   "code": "LBP",
    //   "image": "assets/countyImage/LBP.svg",
    //   "country_name": "Lebanese Pound",
    //   "Symbol": "ل.ل.‎"
    // },
    // {
    //   "code": "LKR",
    //   "image": "assets/countyImage/LKR.svg",
    //   "country_name": "Shri Lankan Rupee ",
    //   "Symbol": " රු"
    // },
    // {
    //   "code": "LRD",
    //   "image": "assets/countyImage/LRD.svg",
    //   "country_name": "Liberian Dollar",
    //   "Symbol": "L\$"
    // },
    // {
    //   "code": "LSL",
    //   "image": "assets/countyImage/LSL.svg",
    //   "country_name": "Lesotho Loti ",
    //   "Symbol": "M"
    // },
    // {
    //   "code": "LYD",
    //   "image": "assets/countyImage/LYD.svg",
    //   "country_name": "Libyan Dinar",
    //   "Symbol": "ل.د"
    // },
    // {
    //   "code": "MAD",
    //   "image": "assets/countyImage/MAD.svg",
    //   "country_name": "Moroccan Dirham ",
    //   "Symbol": "MAD"
    // },
    // {
    //   "code": "MDL",
    //   "image": "assets/countyImage/MDL.svg",
    //   "country_name": "Moldovan Leu",
    //   "Symbol": "L"
    // },
    // {
    //   "code": "MGA",
    //   "image": "assets/countyImage/MGA.svg",
    //   "country_name": "Malagasy Ariary",
    //   "Symbol": "Ar"
    // },
    // {
    //   "code": "MKD",
    //   "image": "assets/countyImage/MKD.svg",
    //   "country_name": "Macedonian Denar",
    //   "Symbol": "Ден"
    // },
    // {
    //   "code": "MMK",
    //   "image": "assets/countyImage/MMK.svg",
    //   "country_name": "Myanma Kyat",
    //   "Symbol": "K"
    // },
    // {
    //   "code": "MNT",
    //   "image": "assets/countyImage/MNT.svg",
    //   "country_name": "Mongolian Tugrik",
    //   "Symbol": "₮"
    // },
    // {
    //   "code": "MOP",
    //   "image": "assets/countyImage/MOP.svg",
    //   "country_name": "Macanese Pataca",
    //   "Symbol": "MOP\$"
    // },
    // {
    //   "code": "MRO",
    //   "image": "assets/countyImage/MRO.svg",
    //   "country_name": "Mauritanian Ouguiya",
    //   "Symbol": "UM"
    // },
    // {
    //   "code": "MUR",
    //   "image": "assets/countyImage/MUR.svg",
    //   "country_name": "Maurtitian Rupee ",
    //   "Symbol": "₨"
    // },
    // {
    //   "code": "MRU",
    //   "image": "assets/countyImage/MRU.svg",
    //   "country_name": "	Mauritanian Ouguiya ",
    //   "Symbol": "MRU"
    // },
    // {
    //   "code": "MVR",
    //   "image": "assets/countyImage/MVR.svg",
    //   "country_name": "Maldivian Rufiya",
    //   "Symbol": "MRf"
    // },
    // {
    //   "code": "MWK",
    //   "image": "assets/countyImage/MWK.svg",
    //   "country_name": "Malawian Kwacha",
    //   "Symbol": "MK"
    // },
    // {
    //   "code": "MXN",
    //   "image": "assets/countyImage/MXN.svg",
    //   "country_name": " Mexican Peso",
    //   "Symbol": "Mex\$"
    // },
    // {
    //   "code": "MYR",
    //   "image": "assets/countyImage/MYR.svg",
    //   "country_name": "  Malaysian Ringgit",
    //   "Symbol": "RM"
    // },
    // {
    //   "code": "MZN",
    //   "image": "assets/countyImage/MZN.svg",
    //   "country_name": "Mozambican Metical",
    //   "Symbol": "MT"
    // },
    // {
    //   "code": "NAD",
    //   "image": "assets/countyImage/NAD.svg",
    //   "country_name": "Namibian Dollar",
    //   "Symbol": "€"
    // },
    // {
    //   "code": "NGN",
    //   "image": "assets/countyImage/NGN.svg",
    //   "country_name": "Nigerian Naira",
    //   "Symbol": "₦"
    // },
    // {
    //   "code": "NIO",
    //   "image": "assets/countyImage/NIO.svg",
    //   "country_name": "Nicaraguan Cordoba",
    //   "Symbol": "C\$"
    // },
    // {
    //   "code": "NOK",
    //   "image": "assets/countyImage/NOK.svg",
    //   "country_name": "Norwegian Krone",
    //   "Symbol": "kr"
    // },
    // {
    //   "code": "NPR",
    //   "image": "assets/countyImage/NPR.svg",
    //   "country_name": "Nepalese Rupee",
    //   "Symbol": "रू"
    // },
    // {
    //   "code": "NZD",
    //   "image": "assets/countyImage/NZD.svg",
    //   "country_name": "New Zealand Dollar",
    //   "Symbol": "\$"
    // },
    {
      "code": "OMR",
      "image": "assets/countyImage/OMR.svg",
      "country_name": "Omani Rial",
      "Symbol": "ر.ع."
    },
    {
      "code": "PAB",
      "image": "assets/countyImage/PAB.svg",
      "country_name": "Panamanian Balboa",
      "Symbol": "B/."
    },
    {
      "code": "AED",
      "image": "assets/countyImage/AED.svg",
      "country_name": "United Arab Emirates Dirha..",
      "Symbol": "د.إ"
    },
    {
      "code": "AFN",
      "image": "assets/countyImage/AFN.svg",
      "country_name": "Ffghan Ffghani ",
      "Symbol": "؋"
    },
    {
      "code": "ALL",
      "image": "assets/countyImage/ALL.svg",
      "country_name": "Albanian Lek",
      "Symbol": "L"
    },
    {
      "code": "AMD",
      "image": "assets/countyImage/AMD.svg",
      "country_name": "Armenian Dram",
      "Symbol": "Դ"
    },
    {
      "code": "ANG",
      "image": "assets/countyImage/ANG.svg",
      "country_name": "Netherlands Antillean Guil..",
      "Symbol": "ƒ"
    },
    {
      "code": "AOA",
      "image": "assets/countyImage/AOA.svg",
      "country_name": "Angolan Kwanza",
      "Symbol": "Kz"
    },
    {
      "code": "ARS",
      "image": "assets/countyImage/ARS3.svg",
      "country_name": "Argentine Peso",
      "Symbol": "\$"
    },
    {
      "code": "AUD",
      "image": "assets/countyImage/AUD.svg",
      "country_name": "Australian Dollar",
      "Symbol": "A\$"
    },
    {
      "code": "AWG",
      "image": "assets/countyImage/AWG.svg",
      "country_name": "Aruban Florin",
      "Symbol": "ƒ"
    },
    {
      "code": "AZN",
      "image": "assets/countyImage/AZN.svg",
      "country_name": "AzerBaijani Manat",
      "Symbol": "AZN"
    },
    {
      "code": "BAM",
      "image": "assets/countyImage/BAM.svg",
      "country_name": "Bosnia-Herzegovina Conve..",
      "Symbol": ""
    },
    {
      "code": "BBD",
      "image": "assets/countyImage/BBD.svg",
      "country_name": "Barbadian Dollar",
      "Symbol": ""
    },
    {
      "code": "BDT",
      "image": "assets/countyImage/BDT.svg",
      "country_name": "Bangladeshi Taka",
      "Symbol": "৳"
    },
    {
      "code": "BGN",
      "image": "assets/countyImage/BGN.svg",
      "country_name": "Bulgarian Lev",
      "Symbol": "Лв"
    },
    {
      "code": "BHD",
      "image": "assets/countyImage/BHD.svg",
      "country_name": "Bahraini Dinar",
      "Symbol": "BD"
    },
    {
      "code": "BIF",
      "image": "assets/countyImage/BIF.svg",
      "country_name": "Burundian France",
      "Symbol": ""
    },
    {
      "code": "BMD",
      "image": "assets/countyImage/BMD.svg",
      "country_name": "Bermudan Dollar",
      "Symbol": "\$"
    },
    {
      "code": "BND",
      "image": "assets/countyImage/BND.svg",
      "country_name": "Brunei Dollar",
      "Symbol": "B\$"
    },
    {
      "code": "BOB",
      "image": "assets/countyImage/BOB.svg",
      "country_name": "Bolivian Boliviano",
      "Symbol": "Bs."
    },
    {
      "code": "BRL",
      "image": "assets/countyImage/BRL.svg",
      "country_name": "Brazilian Real",
      "Symbol": "R\$"
    },
    {
      "code": "BSD",
      "image": "assets/countyImage/BSD.svg",
      "country_name": "Bahamian Dollar",
      "Symbol": "B\$"
    },
    {
      "code": "BTC",
      "image": "assets/countyImage/BTC.svg",
      "country_name": "Bitcoin",
      "Symbol": "₿"
    },
    {
      "code": "BTN",
      "image": "assets/countyImage/BTN.svg",
      "country_name": "Bhutanese Ngultrum",
      "Symbol": "Nu."
    },
    {
      "code": "BWP",
      "image": "assets/countyImage/BWP.svg",
      "country_name": "Botsanan Pula",
      "Symbol": "P"
    },
    {
      "code": "BYN",
      "image": "assets/countyImage/BYN.svg",
      "country_name": "Belarusian Ruble",
      "Symbol": "BYN"
    },
    {
      "code": "BZD",
      "image": "assets/countyImage/BZD.svg",
      "country_name": "Belize Dollar",
      "Symbol": "\$"
    },
    {
      "code": "CAD",
      "image": "assets/countyImage/CAD.svg",
      "country_name": "Canadian Dollar",
      "Symbol": "Can\$"
    },
    {
      "code": "CDF",
      "image": "assets/countyImage/CDF.svg",
      "country_name": "Congolese Franc",
      "Symbol": "FC"
    },
    {
      "code": "CHF",
      "image": "assets/countyImage/CHF.svg",
      "country_name": "Swiss Franc",
      "Symbol": "SFr."
    },
    {"code":"SAR", "image":"assets/countyImage/SAR.svg", "country_name":"Saudi Riyal","Symbol": "SR"},
    {
      "code": "CLP",
      "image": "assets/countyImage/CLP.svg",
      "country_name": "Chilean Peso",
      "Symbol": "\$"
    },
    {
      "code": "CNY",
      "image": "assets/countyImage/CNY.svg",
      "country_name": "Chinese Yuan",
      "Symbol": "¥"
    },
    {
      "code": "COP",
      "image": "assets/countyImage/COP.svg",
      "country_name": "Colombian Peso",
      "Symbol": "\$"
    },
    {
      "code": "CRC",
      "image": "assets/countyImage/CRC.svg",
      "country_name": "Costa Rican Colon",
      "Symbol": "₡"
    },
    {
      "code": "CUP",
      "image": "assets/countyImage/CUP.svg",
      "country_name": "Cuban Peso",
      "Symbol": "₱"
    },
    {
      "code": "CVE",
      "image": "assets/countyImage/CVE.svg",
      "country_name": "Cape Verdean Escudo",
      "Symbol": "Esc"
    },
    {
      "code": "CZK",
      "image": "assets/countyImage/CZK.svg",
      "country_name": "Czech Republic Koruna",
      "Symbol": "Kč"
    },
    {
      "code": "CLF",
      "image": "assets/countyImage/CLF.svg",
      "country_name": "Unidad de Fomento",
      "Symbol": "UF"
    },
    {
      "code": "CNH",
      "image": "assets/countyImage/CNH.svg",
      "country_name": "Renminbi",
      "Symbol": "¥."
    },
    {
      "code": "CVC",
      "image": "assets/countyImage/CVC.svg",
      "country_name": "Cabo Verde Escudoa",
      "Symbol": ""
    },
    {
      "code": "CUC",
      "image": "assets/countyImage/CUC.svg",
      "country_name": "Cuban Convertible Peso",
      "Symbol": "CUC\$"
    },
    {
      "code": "DJF",
      "image": "assets/countyImage/DJF.svg",
      "country_name": "Djiboutian Franc",
      "Symbol": "Fdj"
    },
    {
      "code": "DKK",
      "image": "assets/countyImage/DKK.svg",
      "country_name": "Danish Krone",
      "Symbol": "Kr."
    },
    {
      "code": "DOP",
      "image": "assets/countyImage/DOP.svg",
      "country_name": "Dominican Peso",
      "Symbol": " RD\$"
    },
    {
      "code": "DZD",
      "image": "assets/countyImage/DZD.svg",
      "country_name": "Algerian Dinar",
      "Symbol": "دج"
    },
    {
      "code": "EGP",
      "image": "assets/countyImage/EGP.svg",
      "country_name": "Egyptian Pound",
      "Symbol": "ج.م"
    },
    {
      "code": "ERN",
      "image": "assets/countyImage/ERN.svg",
      "country_name": "Eritrean Nakfa",
      "Symbol": " ናቕፋ"
    },
    {
      "code": "ETB",
      "image": "assets/countyImage/ETB.svg",
      "country_name": "Ethiopian Birr",
      "Symbol": "ብር"
    },
    {
      "code": "EUR",
      "image": "assets/countyImage/EUR.svg",
      "country_name": " Euro",
      "Symbol": "€"
    },
    {
      "code": "FJD",
      "image": "assets/countyImage/FJD.svg",
      "country_name": "Fijian Dollar",
      "Symbol": "FJ\$"
    },
    {
      "code": "FKP",
      "image": "assets/countyImage/FKP1.svg",
      "country_name": "Falkland Islands Pound",
      "Symbol": "£"
    },
    {
      "code": "GBP",
      "image": "assets/countyImage/GBP.svg",
      "country_name": "British Pound Sterling",
      "Symbol": "£"
    },
    {
      "code": "GEL",
      "image": "assets/countyImage/GEL.svg",
      "country_name": " Geogian Lari ",
      "Symbol": "ლ"
    },
    {
      "code": "GHS",
      "image": "assets/countyImage/GHS.svg",
      "country_name": " Ghanaian Cedi ",
      "Symbol": " GH₵"
    },
    {
      "code": "GIP",
      "image": "assets/countyImage/GIP.svg",
      "country_name": "Gibraltar Pround",
      "Symbol": "£"
    },
    {
      "code": "GGP",
      "image": "assets/countyImage/GGP.svg",
      "country_name": "	Guernsey Pound ",
      "Symbol": "£"
    },
    {
      "code": "GMD",
      "image": "assets/countyImage/GMD.svg",
      "country_name": "Gambian Dalasi",
      "Symbol": "D"
    },
    {
      "code": "GNF",
      "image": "assets/countyImage/GNF.svg",
      "country_name": "Guinean Franc",
      "Symbol": "GFr"
    },
    {
      "code": "GTQ",
      "image": "assets/countyImage/GTQ.svg",
      "country_name": "Guatemalan Quetzal ",
      "Symbol": "Q"
    },
    {
      "code": "GYD",
      "image": "assets/countyImage/GYD.svg",
      "country_name": "Guyanaese Dollar",
      "Symbol": " GY\$"
    },
    {
      "code": "HKD",
      "image": "assets/countyImage/HKD.svg",
      "country_name": "Hong Kong Dollar",
      "Symbol": ""
    },
    {
      "code": "HNL",
      "image": "assets/countyImage/HNL.svg",
      "country_name": "Honduran Lempira",
      "Symbol": "HK\$"
    },
    {
      "code": "HRK",
      "image": "assets/countyImage/HRK.svg",
      "country_name": "Croatian Kuna",
      "Symbol": "kn"
    },
    {
      "code": "HTG",
      "image": "assets/countyImage/HTG.svg",
      "country_name": "Haitian Gourda",
      "Symbol": "G"
    },
    {
      "code": "HUF",
      "image": "assets/countyImage/HUF.svg",
      "country_name": "Hungarian Forint",
      "Symbol": "Ft"
    },
    {
      "code": "IDR",
      "image": "assets/countyImage/IDR.svg",
      "country_name": "Indonesian Rupiah",
      "Symbol": "Rp"
    },
    {
      "code": "ILS",
      "image": "assets/countyImage/ILS.svg",
      "country_name": "Israeli New Sheqel",
      "Symbol": "₪"
    },
    {
      "code": "INR",
      "image": "assets/countyImage/INR.svg",
      "country_name": "Indian Rupee",
      "Symbol": "₹"
    },
    {
      "code": "IQD",
      "image": "assets/countyImage/IQD.svg",
      "country_name": "Iraqi Dinar",
      "Symbol": "ع.د"
    },
    {
      "code": "IRR",
      "image": "assets/countyImage/IRR.svg",
      "country_name": "Iranian Rial",
      "Symbol": "﷼"
    },
    {
      "code": "ISK",
      "image": "assets/countyImage/ISK.svg",
      "country_name": "Icelandic Krona",
      "Symbol": "Íkr"
    },
    {
      "code": "IMP",
      "image": "assets/countyImage/IMP.svg",
      "country_name": "	Isle of Man Pound",
      "Symbol": "£"
    },
    {
      "code": "JMD",
      "image": "assets/countyImage/JMD.svg",
      "country_name": "Jamaican Dollar",
      "Symbol": "\$"
    },
    {
      "code": "JOD",
      "image": "assets/countyImage/JOD.svg",
      "country_name": "Jordanian Dinar",
      "Symbol": "د.ا"
    },
    {
      "code": "JPY",
      "image": "assets/countyImage/JPY.svg",
      "country_name": "Japanese Yen",
      "Symbol": "圓"
    },
    {
      "code": "JEP",
      "image": "assets/countyImage/JEP.svg",
      "country_name": "Jersey Pound",
      "Symbol": "£"
    },
    {
      "code": "KES",
      "image": "assets/countyImage/KES.svg",
      "country_name": "Ke	South Korean ..",
      "Symbol": "Ksh"
    },
    {
      "code": "KGS",
      "image": "assets/countyImage/KGS.svg",
      "country_name": "Kyrgystani Som",
      "Symbol": "Лв"
    },
    {
      "code": "KHR",
      "image": "assets/countyImage/KHR.svg",
      "country_name": "Cambodian Rial",
      "Symbol": "៛"
    },
    {
      "code": "KMF",
      "image": "assets/countyImage/KMF.svg",
      "country_name": "Comoraian Franc",
      "Symbol": "CF"
    },
    {
      "code": "KPW",
      "image": "assets/countyImage/KPW.svg",
      "country_name": "North Korean Won",
      "Symbol": "₩"
    },
    {
      "code": "KWD",
      "image": "assets/countyImage/KWD.svg",
      "country_name": "Kuwaiti Dinar",
      "Symbol": "د.ك"
    },
    {
      "code": "KYD",
      "image": "assets/countyImage/KYD.svg",
      "country_name": "Cayman Islands Dollar",
      "Symbol": "\$"
    },
    {
      "code": "KZT",
      "image": "assets/countyImage/KZT.svg",
      "country_name": "Kazakhstani Tenge",
      "Symbol": "₸"
    },
    {
      "code": "KRW",
      "image": "assets/countyImage/KRW.svg",
      "country_name": "	South Korean Won",
      "Symbol": "₩"
    },
    {
      "code": "LAK",
      "image": "assets/countyImage/LAK.svg",
      "country_name": "Laotian Kip",
      "Symbol": "₭N"
    },
    {
      "code": "LBP",
      "image": "assets/countyImage/LBP.svg",
      "country_name": "Lebanese Pound",
      "Symbol": "ل.ل.‎"
    },
    {
      "code": "LKR",
      "image": "assets/countyImage/LKR.svg",
      "country_name": "Shri Lankan Rupee ",
      "Symbol": " රු"
    },
    {
      "code": "LRD",
      "image": "assets/countyImage/LRD.svg",
      "country_name": "Liberian Dollar",
      "Symbol": "L\$"
    },
    {
      "code": "LSL",
      "image": "assets/countyImage/LSL.svg",
      "country_name": "Lesotho Loti ",
      "Symbol": "M"
    },
    {
      "code": "LYD",
      "image": "assets/countyImage/LYD.svg",
      "country_name": "Libyan Dinar",
      "Symbol": "ل.د"
    },
    {
      "code": "MAD",
      "image": "assets/countyImage/MAD.svg",
      "country_name": "Moroccan Dirham ",
      "Symbol": "MAD"
    },
    {
      "code": "MDL",
      "image": "assets/countyImage/MDL.svg",
      "country_name": "Moldovan Leu",
      "Symbol": "L"
    },
    {
      "code": "MGA",
      "image": "assets/countyImage/MGA.svg",
      "country_name": "Malagasy Ariary",
      "Symbol": "Ar"
    },
    {
      "code": "MKD",
      "image": "assets/countyImage/MKD.svg",
      "country_name": "Macedonian Denar",
      "Symbol": "Ден"
    },
    {
      "code": "MMK",
      "image": "assets/countyImage/MMK.svg",
      "country_name": "Myanma Kyat",
      "Symbol": "K"
    },
    {
      "code": "MNT",
      "image": "assets/countyImage/MNT.svg",
      "country_name": "Mongolian Tugrik",
      "Symbol": "₮"
    },
    {
      "code": "MOP",
      "image": "assets/countyImage/MOP.svg",
      "country_name": "Macanese Pataca",
      "Symbol": "MOP\$"
    },
    {
      "code": "MRO",
      "image": "assets/countyImage/MRO.svg",
      "country_name": "Mauritanian Ouguiya",
      "Symbol": "UM"
    },
    {
      "code": "MUR",
      "image": "assets/countyImage/MUR.svg",
      "country_name": "Maurtitian Rupee ",
      "Symbol": "₨"
    },
    {
      "code": "MRU",
      "image": "assets/countyImage/MRU.svg",
      "country_name": "	Mauritanian Ouguiya ",
      "Symbol": "MRU"
    },
    {
      "code": "MVR",
      "image": "assets/countyImage/MVR.svg",
      "country_name": "Maldivian Rufiya",
      "Symbol": "MRf"
    },
    {
      "code": "MWK",
      "image": "assets/countyImage/MWK.svg",
      "country_name": "Malawian Kwacha",
      "Symbol": "MK"
    },
    {
      "code": "MXN",
      "image": "assets/countyImage/MXN.svg",
      "country_name": " Mexican Peso",
      "Symbol": "Mex\$"
    },
    {
      "code": "MYR",
      "image": "assets/countyImage/MYR.svg",
      "country_name": "  Malaysian Ringgit",
      "Symbol": "RM"
    },
    {
      "code": "MZN",
      "image": "assets/countyImage/MZN.svg",
      "country_name": "Mozambican Metical",
      "Symbol": "MT"
    },
    {
      "code": "NAD",
      "image": "assets/countyImage/NAD.svg",
      "country_name": "Namibian Dollar",
      "Symbol": "€"
    },
    {
      "code": "NGN",
      "image": "assets/countyImage/NGN.svg",
      "country_name": "Nigerian Naira",
      "Symbol": "₦"
    },
    {
      "code": "NIO",
      "image": "assets/countyImage/NIO.svg",
      "country_name": "Nicaraguan Cordoba",
      "Symbol": "C\$"
    },
    {
      "code": "NOK",
      "image": "assets/countyImage/NOK.svg",
      "country_name": "Norwegian Krone",
      "Symbol": "kr"
    },
    {
      "code": "NPR",
      "image": "assets/countyImage/NPR.svg",
      "country_name": "Nepalese Rupee",
      "Symbol": "रू"
    },
    {
      "code": "NZD",
      "image": "assets/countyImage/NZD.svg",
      "country_name": "New Zealand Dollar",
      "Symbol": "\$"
    },
    {
      "code": "PEN",
      "image": "assets/countyImage/PEN.svg",
      "country_name": "Peruvian Nuevo Sol",
      "Symbol": "K"
    },
    {
      "code": "PGK",
      "image": "assets/countyImage/PGK.svg",
      "country_name": "Papua New Guinean Kina",
      "Symbol": "S/"
    },
    {
      "code": "PHP",
      "image": "assets/countyImage/PHP.svg",
      "country_name": "Philippine Rupee",
      "Symbol": "(₱)"
    },
    {
      "code": "PKR",
      "image": "assets/countyImage/PKR.svg",
      "country_name": "Pakistani Rupee",
      "Symbol": "₨"
    },
    {
      "code": "PLN",
      "image": "assets/countyImage/PLN.svg",
      "country_name": "Polish Zloty",
      "Symbol": "zł"
    },
    {
      "code": "PYG",
      "image": "assets/countyImage/PYG.svg",
      "country_name": "Paraguayan Guarani",
      "Symbol": "₲"
    },
    {
      "code": "QAR",
      "image": "assets/countyImage/QAR.svg",
      "country_name": "Qatari Rial",
      "Symbol": "ر.ق"
    },
    {
      "code": "RON",
      "image": "assets/countyImage/RON.svg",
      "country_name": "Romanian leu",
      "Symbol": "lei"
    },
    {
      "code": "RSD",
      "image": "assets/countyImage/RSD.svg",
      "country_name": "Serbian Dinar",
      "Symbol": "din"
    },
    {
      "code": "RUB",
      "image": "assets/countyImage/RUB.svg",
      "country_name": "Russian Ruble",
      "Symbol": "₽"
    },
    {
      "code": "RWF",
      "image": "assets/countyImage/RWF.svg",
      "country_name": "Rwandan Franc",
      "Symbol": "FRw"
    },
    {
      "code": "SBD",
      "image": "assets/countyImage/SBD.svg",
      "country_name": "Salomon Islands Dollar",
      "Symbol": "Si\$"
    },
    {
      "code": "SCR",
      "image": "assets/countyImage/SCR.svg",
      "country_name": "Seychellois Rupee",
      "Symbol": "₨ /-"
    },
    {
      "code": "SDG",
      "image": "assets/countyImage/SDG.svg",
      "country_name": "Sudanese Pound",
      "Symbol": "ج.س."
    },
    {
      "code": "SEK",
      "image": "assets/countyImage/SEK.svg",
      "country_name": "Swedish Krona ",
      "Symbol": "kr"
    },
    {
      "code": "SGD",
      "image": "assets/countyImage/SGD.svg",
      "country_name": "Singapore Dollar ",
      "Symbol": "S\$"
    },
    {
      "code": "SHP",
      "image": "assets/countyImage/SHP.svg",
      "country_name": "Saint Helena Pound",
      "Symbol": "£"
    },
    {
      "code": "SLL",
      "image": "assets/countyImage/SLL.svg",
      "country_name": "Sierra Leonean Leone",
      "Symbol": "Le"
    },
    {
      "code": "SOS",
      "image": "assets/countyImage/SOS.svg",
      "country_name": "Somali Shilling",
      "Symbol": "Sh.so."
    },
    {
      "code": "SRD",
      "image": "assets/countyImage/SRD.svg",
      "country_name": "Surinamese Dollar",
      "Symbol": "\$"
    },
    {
      "code": "SSP",
      "image": "assets/countyImage/SSP.svg",
      "country_name": "South Sudanese Pound",
      "Symbol": "£"
    },
    {
      "code": "STD",
      "image": "assets/countyImage/STD.svg",
      "country_name": "Sao Tomean Dobra",
      "Symbol": "Db"
    },
    {
      "code": "STN",
      "image": "assets/countyImage/STN.svg",
      "country_name": "São Tomé and Príncipe",
      "Symbol": "Db"
    },
    {
      "code": "SYP",
      "image": "assets/countyImage/SYP.svg",
      "country_name": "Syrian Pound",
      "Symbol": "£S "
    },
    {
      "code": "SZL",
      "image": "assets/countyImage/SZL.svg",
      "country_name": "Swazi Lilangebi",
      "Symbol": "L"
    },
    {
      "code": "SVC",
      "image": "assets/countyImage/SVC.svg",
      "country_name": "El Salvador Colon",
      "Symbol": "₡"
    },
    {
      "code": "THB",
      "image": "assets/countyImage/THB.svg",
      "country_name": "Thai Baht",
      "Symbol": "฿"
    },
    {
      "code": "TJS",
      "image": "assets/countyImage/TJS.svg",
      "country_name": "Tajikistani Somoni",
      "Symbol": "ЅM"
    },
    {
      "code": "TMT",
      "image": "assets/countyImage/TMT.svg",
      "country_name": "Turkmenistani Manat",
      "Symbol": "T"
    },
    {
      "code": "TND",
      "image": "assets/countyImage/TND.svg",
      "country_name": "Tunisian Dinar",
      "Symbol": " د.ت "
    },
    {
      "code": "TOP",
      "image": "assets/countyImage/TOP.svg",
      "country_name": "Tongan Pa'anga",
      "Symbol": "T\$"
    },
    {
      "code": "TRY",
      "image": "assets/countyImage/TRY.svg",
      "country_name": "Turkish Lira",
      "Symbol": "₺"
    },
    {
      "code": "TTD",
      "image": "assets/countyImage/TTD.svg",
      "country_name": "Trinidad and Tobago ",
      "Symbol": "TT¢"
    },
    {
      "code": "TWD",
      "image": "assets/countyImage/TWD.svg",
      "country_name": "New Taiwan Dollar",
      "Symbol": "NT\$"
    },
    {
      "code": "TZS",
      "image": "assets/countyImage/TZS.svg",
      "country_name": "Tanzanian Shilling",
      "Symbol": "TSh"
    },
    {
      "code": "UAH",
      "image": "assets/countyImage/UAH.svg",
      "country_name": "Ukrainian Hryvnia",
      "Symbol": "₴"
    },
    {
      "code": "UGX",
      "image": "assets/countyImage/UGX.svg",
      "country_name": "Ugandan Shilling",
      "Symbol": "USh"
    },
    {
      "code": "USD",
      "image": "assets/countyImage/USD.svg",
      "country_name": "United States Dollar",
      "Symbol": "\$"
    },
    {
      "code": "UYU",
      "image": "assets/countyImage/UYU.svg",
      "country_name": "Uruguayan Peso",
      "Symbol": "\$U"
    },
    {
      "code": "UZS",
      "image": "assets/countyImage/UZS.svg",
      "country_name": "Uzbekistan Som",
      "Symbol": "so'm"
    },
    {
      "code": "VES",
      "image": "assets/countyImage/VES.svg",
      "country_name": "Venezuelan Bolivar Fuerte",
      "Symbol": "Bs"
    },
    {
      "code": "VND",
      "image": "assets/countyImage/VND.svg",
      "country_name": "Vietnamese Dong",
      "Symbol": "₫"
    },
    {
      "code": "VUV",
      "image": "assets/countyImage/VUV.svg",
      "country_name": "Vanuatu Vatu ",
      "Symbol": "VT"
    },
    {
      "code": "WST",
      "image": "assets/countyImage/WST.svg",
      "country_name": "Samoan Tala ",
      "Symbol": "SAT"
    },
    {
      "code": "XAF",
      "image": "assets/countyImage/XAF.svg",
      "country_name": "CFA Franc BEAC ",
      "Symbol": "FCFA"
    },
    {
      "code": "XCD",
      "image": "assets/countyImage/XCD.svg",
      "country_name": "East Caribbean Dollar",
      "Symbol": "\$"
    },
    {
      "code": "XOF",
      "image": "assets/countyImage/XOF.svg",
      "country_name": "CFA Franc BCEAO ",
      "Symbol": "CFA"
    },
    {
      "code": "XAG",
      "image": "assets/countyImage/XAG.svg",
      "country_name": "Swazi Lilangebi",
      "Symbol": "E"
    },
    {
      "code": "XAU",
      "image": "assets/countyImage/XAU.svg",
      "country_name": "Vietnam Dong",
      "Symbol": "₫"
    },
    {
      "code": "XDR",
      "image": "assets/countyImage/XDR.svg",
      "country_name": "Special Drawing Rights",
      "Symbol": "SDR"
    },
    {
      "code": "XPD",
      "image": "assets/countyImage/XPD.svg",
      "country_name": "Ounce of palladium",
      "Symbol": "XPD"
    },
    {
      "code": "XPT",
      "image": "assets/countyImage/XPT.svg",
      "country_name": "Ounce of platinum",
      "Symbol": "oz"
    },
    {
      "code": "XPF",
      "image": "assets/countyImage/XPF.svg",
      "country_name": "CFP Franc",
      "Symbol": "Fr."
    },
    {
      "code": "YER",
      "image": "assets/countyImage/YER.svg",
      "country_name": "Yemeni Rial",
      "Symbol": "﷼"
    },
    {
      "code": "ZAR",
      "image": "assets/countyImage/ZAR.svg",
      "country_name": "south African Rand",
      "Symbol": "ZR"
    },
    {
      "code": "ZWL",
      "image": "assets/countyImage/ZWL.svg",
      "country_name": "Zimbabwean dollar",
      "Symbol": "Z\$"
    },
    {
      "code": "ZMW",
      "image": "assets/countyImage/ZMW.svg",
      "country_name": "Zambia",
      "Symbol": "ZK"
    }
  ];
}
