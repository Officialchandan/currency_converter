import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:currency_converter/widget/calculator.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../in_app_parchase/product_provider.dart';
import '../../widget/add_screen_widget.dart';
import 'chart_screen.dart';
import 'currency_from_widget.dart';
import 'currency_to_widget.dart';
import 'home_page.dart';

class TapHome extends StatefulWidget {
  final Function(TabChangeListener tabChangeListener) onInitialize;

  const TapHome({required this.onInitialize, Key? key}) : super(key: key);

  @override
  _TapHomeState createState() => _TapHomeState();
}

class _TapHomeState extends State<TapHome> implements TabChangeListener {
  String symbol2 = "€";
  String symbol = "\$";
  String flagfrom = "assets/pngCountryImages/USD.png";
  String flagto = "assets/pngCountryImages/EUR.png";
  List<DataModel> countrycode = [];
  final dbHelper = DatabaseHelper.instance;
  String text = "0.00";
  bool arrowPosition = false;
  bool arrowPositionTwo = false;
  double conversionRate = 0;
  bool isCalculatorVisible = false;
  bool _isContainerVisible = false;
  bool _isContainerVisibleTwo = false;
  TextEditingController calculateCurrency =
      TextEditingController(text: Constants.inputValue);
  TextEditingController edtFrom = TextEditingController(text: "USD");
  TextEditingController edtTo = TextEditingController(text: "EUR");
  String currencyCodeFrom = "USD";
  String currencyCodeTo = "INR";
  late InAppProvider _inAppProvider;
  @override
  void initState() {
    getValue();
    final provider = Provider.of<InAppProvider>(context, listen: false);
    _inAppProvider = provider;
    _isContainerVisible = false;
    _isContainerVisibleTwo = false;
    getHistory();
    widget.onInitialize(this);
    getCurrencyCode();
    initializeDateFormatting();
    Utility.getFormatDate();
    Utility.check();
    getAds();
    SchedulerBinding.instance!.addPostFrameCallback((_) {});
    super.initState();
  }

  getAds() async {
    Constants.isPurchaseOfAds =
        await Utility.getIntPreference(Constants.yearCheckTimeCons);
    print('isPurchaseOfAds->${Constants.isPurchaseOfAds}');

    if (Constants.isPurchaseOfAds == 0) {
      await Utility.setBooleanPreference(
          Constants.checkWidgetPurchaseAds, false);
    } else {
      DateTime purchaseTime =
          DateTime.fromMillisecondsSinceEpoch(Constants.isPurchaseOfAds);
      DateTime dayTimeNow = DateTime(Constants.timeNow.year,
          Constants.timeNow.month, Constants.timeNow.day);
      DateTime yearCheckTime = DateTime(
          purchaseTime.year, purchaseTime.month, purchaseTime.day + 365);
      if (dayTimeNow.millisecond <= yearCheckTime.microsecond) {
        print("dayTimeNowdayTimeNow");
        await Utility.setBooleanPreference(
            Constants.checkWidgetPurchaseAds, true);
      } else {
        print("falseFalseFalse");
        await Utility.setBooleanPreference(
            Constants.checkWidgetPurchaseAds, false);
      }
    }
    bool myValue =
        await Utility.getBooleanPreference(Constants.checkWidgetPurchaseAds);
    print('myValue->$myValue');
  }

  getHistory() async {
    await _inAppProvider.initPlatformState();
    // await _inAppProvider.validateReceipt();
    await _inAppProvider.getPurchaseHistoryOfAds();
    await _inAppProvider.getPurchaseHistoryOfColors();
    debugPrint("Constants.isPurchaseOfAds${Constants.isPurchaseOfAds}");
    debugPrint("Constants.isPurchaseOfColors${Constants.isPurchaseOfColors}");
  }

  @override
  void onTabChange() async {
    await Utility.getBooleanPreference(Constants.REMOVE_AD);
    isCalculatorVisible = false;
    _isContainerVisible = false;
    _isContainerVisibleTwo = false;
    setStateIfMounted();
  }

  getValue() async {
    Constants.inputValue =
        await Utility.getStringPreference(Constants.currencyInputValue);
    print("Constants.inputValue-->${Constants.inputValue}");
    if (Constants.inputValue.isEmpty) {
      calculateCurrency.text = "1";
      text = await getConverterAPI(
          currencyCodeFrom, currencyCodeTo, calculateCurrency.text);
    } else if (Constants.inputValue == "0") {
      calculateCurrency.text = "1";
      text = await getConverterAPI(
          currencyCodeFrom, currencyCodeTo, calculateCurrency.text);
    } else {
      calculateCurrency.text = Constants.inputValue;
      text = await getConverterAPI(
          currencyCodeFrom, currencyCodeTo, calculateCurrency.text);
    }
    await Utility.getBooleanPreference(Constants.REMOVE_AD);
    isCalculatorVisible = false;
    _isContainerVisible = false;
    _isContainerVisibleTwo = false;
    setState(() {});
  }

  getCurrencyCode() async {
    final prefs = await SharedPreferences.getInstance();
    await Utility.getLangIndexPreference("LanuageIndex");
    currencyCodeFrom = prefs.getString(Constants.currencyCodeFrom) ?? "USD";
    currencyCodeTo = prefs.getString(Constants.currencyCodeTo) ?? "EUR";
    if (currencyCodeFrom.isNotEmpty && currencyCodeTo.isNotEmpty) {
      edtFrom.text = currencyCodeFrom;
      edtTo.text = currencyCodeTo;
      flagfrom = "assets/pngCountryImages/$currencyCodeFrom.png";
      flagto = "assets/pngCountryImages/$currencyCodeTo.png";
      symbol = await Utility.getSymbolFromPreference("hello");
      symbol2 = await Utility.getSymboltoPreference("to");
      text = await getConverterAPI(
          currencyCodeFrom, currencyCodeTo, calculateCurrency.text);
    }
    setStateIfMounted();
  }

  void currencyCodeFromSave(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.currencyCodeFrom, code);
  }

  void currencyCodeToSave(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.currencyCodeTo, code);
  }

  setStateIfMounted() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    calculateCurrency.clear();
    calculateCurrency.text = "0";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          if (_isContainerVisible ||
              _isContainerVisibleTwo ||
              isCalculatorVisible) {
            Future.value(_isContainerVisible = false);
            Future.value(_isContainerVisibleTwo = false);
            Future.value(isCalculatorVisible = false);
            Future.value(_isContainerVisible = false);
            Future.value(_isContainerVisibleTwo = false);
            setState(() {});
          } else {
            SystemNavigator.pop();
          }
          throw true;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
            height: appheight,
            width: appwidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    toolbarHeight: 50,
                    title: Text(
                      "updated_date".tr().toString() +
                          " " +
                          Utility.getFormatDate().toString(),
                      textScaleFactor: Constants.textScaleFactor,
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 16.5,
                      ),
                    ),
                    leading: Container(),
                    actions: [
                      InkWell(
                        onTap: () {
                          _onShareWithEmptyOrigin(context);
                        },
                        child: Icon(
                          Icons.share,
                          color: MyColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: appwidth - 20,
                    height: 50,
                    decoration: BoxDecoration(
                      color: MyColors.textColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 35.0,
                            width: 60.0,
                            margin: const EdgeInsets.only(left: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  colors: [
                                    MyColors.colorPrimary.withOpacity(0.4),
                                    MyColors.colorPrimary,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: MyColors.displaycode
                                  ? Center(
                                      child: AutoSizeText(
                                        currencyCodeFrom,
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: TextStyle(
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  : MyColors.displaysymbol
                                      ? Center(
                                          child: Text(
                                            symbol,
                                            textScaleFactor:
                                                Constants.textScaleFactor,
                                            style: TextStyle(
                                              color: MyColors.textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: AutoSizeText(
                                            currencyCodeFrom,
                                            textScaleFactor:
                                                Constants.textScaleFactor,
                                            style: TextStyle(
                                              color: MyColors.textColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            // width: 150,
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                textScaleFactor: Constants.textScaleFactor,
                              ),
                              child: AutoSizeTextField(
                                controller: calculateCurrency,
                                textAlignVertical: TextAlignVertical.center,
                                autocorrect: true,
                                maxLength: 30,
                                maxLines: 1,
                                maxFontSize: 18.0,
                                minFontSize: 7.0,
                                cursorColor: MyColors.colorPrimary,
                                style: TextStyle(
                                  color: MyColors.colorPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.none,
                                showCursor: true,
                                readOnly: false,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 1.0, right: 1.0, bottom: 15.0),
                                    counterText: "",
                                    border: InputBorder.none),
                                onTap: () {
                                  isCalculatorVisible = true;
                                  _isContainerVisible = false;
                                  _isContainerVisibleTwo = false;
                                  setState(() {});
                                },
                                onChanged: (text) async {
                                  print("onchange>$text");

                                  if (text.isEmpty) {
                                    text = "0";
                                  }
                                  text = text.replaceAll(RegExp(r'[^0-9]'), '');
                                  debugPrint("aStr---------> $text");

                                  // Constants.inputValue = text;
                                  await Utility.setStringPreference(
                                      Constants.currencyInputValue,
                                      text.trim());
                                  getConverterAPI(
                                      currencyCodeFrom, currencyCodeTo, text);
                                  calculateCurrency.text = text;
                                  calculateCurrency.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              calculateCurrency.text.length));
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  String temp = "";
                                  temp = currencyCodeFrom;
                                  currencyCodeFrom = currencyCodeTo;
                                  currencyCodeTo = temp;

                                  edtFrom.text = currencyCodeFrom;
                                  edtTo.text = currencyCodeTo;

                                  String temp3 = "";
                                  temp3 = symbol;
                                  symbol = symbol2;
                                  symbol2 = temp3;

                                  String temp1 = "";
                                  temp1 = flagfrom;
                                  flagfrom = flagto;
                                  flagto = temp1;

                                  currencyCodeFromSave(currencyCodeFrom);
                                  currencyCodeToSave(currencyCodeTo);
                                  setState(() {});

                                  getConverterAPI(currencyCodeFrom,
                                      currencyCodeTo, calculateCurrency.text);
                                  calculateCurrency.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              calculateCurrency.text.length));
                                },
                                child: SvgPicture.asset(
                                  "assets/images/Path 436.svg",
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Container(
                          width: appwidth * 0.45,
                          height: 50,
                          decoration: BoxDecoration(
                            color: MyColors.textColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.5),
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                textScaleFactor: Constants.textScaleFactor,
                              ),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  textScaleFactor: Constants.textScaleFactor,
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: MyColors.insideTextFieldColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                    fontSize: 18,
                                  ),
                                  controller: edtFrom,
                                  showCursor: false,
                                  readOnly: true,
                                  autofocus: false,
                                  onTap: () {
                                    if (_isContainerVisible) {
                                      _isContainerVisible = false;
                                    } else {
                                      isCalculatorVisible = false;
                                      _isContainerVisible = true;
                                    }
                                    if (_isContainerVisibleTwo) {
                                      _isContainerVisibleTwo = false;
                                    }

                                    if (_isContainerVisible == false &&
                                        _isContainerVisibleTwo == false) {}

                                    setState(() {
                                      arrowPosition = !arrowPosition;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 9.5,
                                      width: 9.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset(
                                          flagfrom,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: SvgPicture.asset(
                                          "assets/images/ic_chevron_left_24px.svg",
                                          height: 15.0,
                                          width: 20.0,
                                          fit: BoxFit.scaleDown,
                                          color: !MyColors.isDarkMode
                                              ? const Color(0xff333333)
                                              : Colors.grey.shade400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      const Spacer(),
                      InkWell(
                          child: Container(
                        width: appwidth * 0.45,
                        height: 50,
                        decoration: BoxDecoration(
                          color: MyColors.textColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.5),
                          child: MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: Constants.textScaleFactor,
                            ),
                            child: TextField(
                              style: TextStyle(
                                color: MyColors.insideTextFieldColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                fontSize: 18,
                              ),
                              controller: edtTo,
                              showCursor: false,
                              readOnly: true,
                              autofocus: false,
                              // keyboardType: TextInputType.none,
                              onTap: () {
                                if (_isContainerVisibleTwo) {
                                  _isContainerVisibleTwo = false;
                                } else {
                                  _isContainerVisible = false;
                                  isCalculatorVisible = false;
                                  _isContainerVisibleTwo = true;
                                }
                                if (_isContainerVisible == false &&
                                    _isContainerVisibleTwo == false) {}

                                setState(() {
                                  arrowPositionTwo = !arrowPositionTwo;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 15,
                                  height: 15,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      flagto,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_chevron_left_24px.svg",
                                    height: 15.0,
                                    width: 20.0,
                                    fit: BoxFit.scaleDown,
                                    color: MyColors.isDarkMode
                                        ? Colors.grey.shade400
                                        : const Color(0xff333333),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(),
                  _isContainerVisible
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          constraints: const BoxConstraints(),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.8),
                          child: SvgPicture.asset(
                            "assets/images/arrow-top.svg",
                          ),
                        )
                      : Container(),
                  _isContainerVisibleTwo
                      ? Container(
                          constraints: const BoxConstraints(),
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2),
                          child: SvgPicture.asset(
                            "assets/images/arrow-top.svg",
                          ),
                        )
                      : Container(),
                  _isContainerVisible
                      ? IntrinsicHeight(
                          child: CurrencyFromWidget(
                            isContainerVisible: _isContainerVisible,
                            onSelect: (String currencyCode, String image,
                                String symbol1) {
                              symbol = symbol1;
                              currencyCodeFrom = currencyCode;
                              flagfrom = image;
                              Utility.setSymbolFromPreference("hello", symbol);

                              currencyCodeFromSave(currencyCodeFrom);
                              edtFrom.text = currencyCode;

                              _isContainerVisible = false;
                              getConverterAPI(currencyCodeFrom, currencyCodeTo,
                                  calculateCurrency.text);
                              calculateCurrency.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: calculateCurrency.text.length));

                              setState(() {});
                            },
                          ),
                        )
                      : _isContainerVisibleTwo
                          ? IntrinsicHeight(
                              child: CurrencyToWidget(
                                isContainerVisibleTwo: _isContainerVisibleTwo,
                                onSelect: (String currencyCode, String image,
                                    String symbol) {
                                  symbol2 = symbol;
                                  flagto = image;
                                  Utility.setSymbolFromPreference(
                                      "to", symbol2);

                                  currencyCodeTo = currencyCode;
                                  currencyCodeToSave(currencyCodeTo);
                                  edtTo.text = currencyCode;
                                  _isContainerVisibleTwo = false;
                                  getConverterAPI(currencyCodeFrom,
                                      currencyCodeTo, calculateCurrency.text);
                                  calculateCurrency.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              calculateCurrency.text.length));
                                  setState(() {});
                                },
                              ),
                            )
                          : const SizedBox(
                              height: 15,
                            ),
                  _isContainerVisible || _isContainerVisibleTwo
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChartScreen(
                                              textFrom: edtFrom.text,
                                              textTo: edtTo.text,
                                            )));
                              },
                              child: Image.asset("assets/images/bar-chart.png",
                                  height: 29.0,
                                  width: 33.0,
                                  fit: BoxFit.scaleDown,
                                  color: MyColors.isDarkMode
                                      ? const Color(0xff333333)
                                      : Colors.white),
                            ),
                          ],
                        ),
                  Center(
                    child: _isContainerVisible || _isContainerVisibleTwo
                        ? Container()
                        : GestureDetector(
                            onLongPress: () {
                              HapticFeedback.vibrate();
                              String decimal = ".00";

                              if (calculateCurrency.text.contains(".")) {
                                decimal = "";
                              }
                              Clipboard.setData(ClipboardData(
                                      text: Utility.getFormatText(
                                              calculateCurrency.text +
                                                  decimal) +
                                          " ${edtFrom.text}" +
                                          "  = " +
                                          Utility.getFormatText(text) +
                                          " ${edtTo.text}" +
                                          " " +
                                          "by_currency_wiki".tr()))
                                  .then((result) {
                                Fluttertoast.showToast(
                                    msg: "copied_to_clipboard".tr(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: const Color(0xff333333),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              });
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          minWidth: 50),
                                      child: AutoSizeText.rich(
                                        TextSpan(
                                          text: Utility.getFormatText(text),
                                        ),
                                        wrapWords: true,
                                        maxLines: 1,
                                        maxFontSize: 32.0,
                                        minFontSize: 5.0,
                                        presetFontSizes: const [
                                          32,
                                          30,
                                          28,
                                          26,
                                          24,
                                          22,
                                          20,
                                          18,
                                          16,
                                          14,
                                          12,
                                          10,
                                          8,
                                          6
                                        ],
                                        softWrap: true,
                                        style: TextStyle(
                                            color: MyColors.textColor,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w400),
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AutoSizeText.rich(
                                    TextSpan(
                                      text: edtTo.text,
                                    ),
                                    textScaleFactor: Constants.textScaleFactor,
                                    maxFontSize: 18.0,
                                    minFontSize: 0.0,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: appheight * 0.03,
                  ),
                  _isContainerVisible || _isContainerVisibleTwo
                      ? const SizedBox()
                      : const Center(child: AddScreenWidget())
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
              // height: isCalculatorVisible ? MediaQuery.of(context).size.height * 0.32000 : 0.0,
              // width: isCalculatorVisible ? MediaQuery.of(context).size.width : 0.0,
              // child: calculator(),
              child: isCalculatorVisible
                  ? Calculator(
                      txtController: calculateCurrency,
                      onChange: (text) async {
                        // Constants.inputValue = text;
                        await Utility.setStringPreference(
                            Constants.currencyInputValue, text.trim());
                        this.text = await getConverterAPI(
                            currencyCodeFrom, currencyCodeTo, text);
                        setState(() {});
                      },
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    )),
        ));
  }

  void showAll() async {
    List<Map<String, dynamic>> allRows = await dbHelper.queryAll();
    allRows.forEach((element) {
      // debugPrint("element-->$element");
      DataModel currencyData = DataModel.fromMap(element);
      countrycode.add(currencyData);
    });
  }

  Future<String> getConverterAPI(String form, String to, String rate) async {
    debugPrint("rate--->$rate");
    await Utility.setStringPreference(
        Constants.currencyInputValue, rate.trim());
    List<Map<String, dynamic>> formRow = await dbHelper.particular_row(form);
    List<Map<String, dynamic>> toRow = await dbHelper.particular_row(to);

    try {
      double a = double.parse(formRow.first.values.toList()[3]);
      double b = double.parse(toRow.first.values.toList()[3]);
      conversionRate = ((a * 100) / (b * 100)) * (double.parse(rate));
      text = conversionRate.toStringAsFixed(MyColors.decimalFormat);
      setStateIfMounted();
      return Utility.getFormatText(text);
    } catch (e) {
      debugPrint(e.toString());
    }
    return text;
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share("https://currencywiki.app/");
  }
}
