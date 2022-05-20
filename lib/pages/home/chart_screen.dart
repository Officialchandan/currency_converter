import 'package:currency_converter/widget/add_screen_widget.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Models/converter_data.dart';
import '../../Themes/colors.dart';
import '../../utils/constants.dart';

class ChartScreen extends StatefulWidget {
  final String textFrom;
  final String textTo;
  const ChartScreen({
    Key? key,
    required this.textFrom,
    required this.textTo,
  }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  _ChartScreenState();
  TrackballBehavior? _trackballBehavior;
  List<ChartSampleData> sampleData = [];
  double maxValue = 0.0;
  double minValue = 0.0;
  bool true24Hours = false;
  bool true7Day = false;
  bool true30Day = false;
  bool true90Day = false;
  bool true1Year = false;
  bool trueAll = true;

  @override
  void initState() {
    init();
    _trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(
          format: 'point.x : point.y',
          borderWidth: 0,
        ));
    super.initState();
  }

  init() async {
    chartDataAll(edtFrom: widget.textFrom, edtTo: widget.textTo);
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = MediaQuery.of(context).size.height;
    var appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Text(
            widget.textFrom +
                "/" +
                widget.textTo +
                " " +
                "line_chart".tr().toString(),
            textScaleFactor: Constants.textScaleFactor,
            style: GoogleFonts.roboto(
              fontSize: 23,
              color: MyColors.textColor,
              fontWeight: FontWeight.w800,
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyColors.textColor,
            size: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _onShareWithEmptyOrigin(context);
            },
            icon: Icon(
              Icons.share,
              color: MyColors.textColor,
              size: 28,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: appHeight,
              width: appWidth,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  MyColors.colorPrimary.withOpacity(0.6),
                  MyColors.colorPrimary.withOpacity(1.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
          ),
          Positioned(
            top: appHeight * 0.1,
            right: 12,
            left: 12,
            child: Container(
              height: appWidth * 0.75,
              child: SfCartesianChart(
                backgroundColor: MyColors.isDarkMode
                    ? const Color(0xff333333)
                    : Colors.white,
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  zoomMode: ZoomMode.x,
                  enablePanning: true,
                  enableDoubleTapZooming: true,
                ),
                primaryYAxis: NumericAxis(
                  majorTickLines: const MajorTickLines(size: 0),
                  majorGridLines: MajorGridLines(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffc4c4c4)),
                  axisLine: AxisLine(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffc4c4c4)),
                  numberFormat: NumberFormat(),
                  labelPosition: ChartDataLabelPosition.inside,
                  labelStyle: TextStyle(
                      color: MyColors.isDarkMode
                          ? const Color(0xffe5e5e5)
                          : const Color(0xff333333),
                      height: 1.5,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400),
                ),
                primaryXAxis: DateTimeAxis(
                  majorTickLines: const MajorTickLines(size: 0),
                  majorGridLines: MajorGridLines(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffc4c4c4)),
                  axisLine: AxisLine(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffc4c4c4)),
                  labelStyle: TextStyle(
                      color: MyColors.isDarkMode
                          ? const Color(0xffe5e5e5)
                          : const Color(0xff333333),
                      height: 1.5,
                      decorationThickness: 2.0,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400),
                ),
                plotAreaBorderWidth: 0,
                series: _getDefaultDateTimeSeries(),
                trackballBehavior: _trackballBehavior,
              ),
            ),
          ),
          Positioned(
              top: appHeight * 0.480,
              right: 0,
              left: 0,
              child: const AddScreenWidget()),
          sampleData.isEmpty
              ? Positioned(
                  top: appHeight * 0.22,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.colorPrimary,
                    ),
                  ),
                )
              : Container(),
          Positioned(
              top: appHeight * 0.03,
              right: 12,
              left: 12,
              child: Container(
                width: appWidth,
                height: appHeight * 0.047,
                decoration: BoxDecoration(
                  color: MyColors.isDarkMode
                      ? const Color(0xff545763)
                      : const Color(0xffeff3f6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        sampleData.clear();
                        true24Hours = true;
                        true7Day = false;
                        true30Day = false;
                        true90Day = false;
                        true1Year = false;
                        trueAll = false;
                        chartData24Hours(
                            edtFrom: widget.textFrom, edtTo: widget.textTo);
                        setState(() {});
                      },
                      child: Container(
                        width: appWidth * 0.13,
                        height: appHeight * 0.035,
                        decoration: BoxDecoration(
                          color: true24Hours && MyColors.isDarkMode
                              ? Colors.black
                              : true24Hours
                                  ? Colors.white
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "24h",
                            textScaleFactor: Constants.textScaleFactor,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: (MyColors.isDarkMode && true24Hours)
                                  ? Colors.white
                                  : (true24Hours)
                                      ? Colors.black
                                      : (MyColors.isDarkMode &&
                                              true24Hours == false)
                                          ? const Color(0xff989eb4)
                                          : const Color(0xff505363),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sampleData.clear();
                        true24Hours = false;
                        true7Day = true;
                        true30Day = false;
                        true90Day = false;
                        true1Year = false;
                        trueAll = false;
                        chartData7Day(
                            edtFrom: widget.textFrom, edtTo: widget.textTo);
                        setState(() {});
                      },
                      child: Container(
                        width: appWidth * 0.13,
                        height: appHeight * 0.035,
                        decoration: BoxDecoration(
                          color: true7Day && MyColors.isDarkMode
                              ? Colors.black
                              : true7Day
                                  ? Colors.white
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "7d",
                            textScaleFactor: Constants.textScaleFactor,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: (MyColors.isDarkMode && true7Day)
                                  ? Colors.white
                                  : (true7Day)
                                      ? Colors.black
                                      : (MyColors.isDarkMode &&
                                              true7Day == false)
                                          ? const Color(0xff989eb4)
                                          : const Color(0xff505363),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sampleData.clear();
                        true24Hours = false;
                        true7Day = false;
                        true30Day = true;
                        true90Day = false;
                        true1Year = false;
                        trueAll = false;
                        chartData30Day(
                            edtFrom: widget.textFrom, edtTo: widget.textTo);
                        setState(() {});
                      },
                      child: Container(
                        width: appWidth * 0.13,
                        height: appHeight * 0.035,
                        decoration: BoxDecoration(
                          color: true30Day && MyColors.isDarkMode
                              ? Colors.black
                              : true30Day
                                  ? Colors.white
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "30d",
                            textScaleFactor: Constants.textScaleFactor,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: (MyColors.isDarkMode && true30Day)
                                  ? Colors.white
                                  : (true30Day)
                                      ? Colors.black
                                      : (MyColors.isDarkMode &&
                                              true30Day == false)
                                          ? const Color(0xff989eb4)
                                          : const Color(0xff505363),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sampleData.clear();
                        true24Hours = false;
                        true7Day = false;
                        true30Day = false;
                        true90Day = true;
                        true1Year = false;
                        trueAll = false;
                        chartData90Day(
                            edtFrom: widget.textFrom, edtTo: widget.textTo);
                        setState(() {});
                      },
                      child: Container(
                        width: appWidth * 0.13,
                        height: appHeight * 0.035,
                        decoration: BoxDecoration(
                          color: true90Day && MyColors.isDarkMode
                              ? Colors.black
                              : true90Day
                                  ? Colors.white
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "90d",
                            textScaleFactor: Constants.textScaleFactor,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: (MyColors.isDarkMode && true90Day)
                                  ? Colors.white
                                  : (true90Day)
                                      ? Colors.black
                                      : (MyColors.isDarkMode &&
                                              true90Day == false)
                                          ? const Color(0xff989eb4)
                                          : const Color(0xff505363),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sampleData.clear();
                        true7Day = false;
                        true24Hours = false;
                        true30Day = false;
                        true90Day = false;
                        true1Year = true;
                        trueAll = false;
                        chartData1Year(
                            edtFrom: widget.textFrom, edtTo: widget.textTo);
                        setState(() {});
                      },
                      child: Container(
                        width: appWidth * 0.13,
                        height: appHeight * 0.035,
                        decoration: BoxDecoration(
                          color: true1Year && MyColors.isDarkMode
                              ? Colors.black
                              : true1Year
                                  ? Colors.white
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "1y",
                            textScaleFactor: Constants.textScaleFactor,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: (MyColors.isDarkMode && true1Year)
                                  ? Colors.white
                                  : (true1Year)
                                      ? Colors.black
                                      : (MyColors.isDarkMode &&
                                              true1Year == false)
                                          ? const Color(0xff989eb4)
                                          : const Color(0xff505363),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sampleData.clear();
                        true7Day = false;
                        true24Hours = false;
                        true30Day = false;
                        true90Day = false;
                        true1Year = false;
                        trueAll = true;
                        chartDataAll(
                            edtFrom: widget.textFrom, edtTo: widget.textTo);
                        setState(() {});
                      },
                      child: Container(
                        width: appWidth * 0.13,
                        height: appHeight * 0.035,
                        decoration: BoxDecoration(
                          color: trueAll && MyColors.isDarkMode
                              ? Colors.black
                              : trueAll
                                  ? Colors.white
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "All",
                            textScaleFactor: Constants.textScaleFactor,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: (MyColors.isDarkMode && trueAll)
                                  ? Colors.white
                                  : (trueAll)
                                      ? Colors.black
                                      : (MyColors.isDarkMode &&
                                              trueAll == false)
                                          ? const Color(0xff989eb4)
                                          : const Color(0xff505363),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share("https://currencywiki.app/");
  }

  List<LineSeries<ChartSampleData, DateTime>> _getDefaultDateTimeSeries() {
    return <LineSeries<ChartSampleData, DateTime>>[
      LineSeries<ChartSampleData, DateTime>(
        dataSource: sampleData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.yValue,
        color: MyColors.colorPrimary,
      )
    ];
  }

  void chartData24Hours(
      {required String edtFrom, required String edtTo}) async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/$edtFrom/$edtTo/784565d2-9c14-4b25-8235-06f6c5029b15";
    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData data = ConverterData.fromMap(response.data);
        sampleData.clear();
        for (int i = 0; i <= 1; i++) {
          double value =
              (data.from!.values.toList().reversed.toList()[i] * 100) /
                  (data.to!.values.toList().reversed.toList()[i] * 100);
          if (i == 0) {
            maxValue = value;
            minValue = value;
          }
          if (value > maxValue) {
            double p = (value * 10) / 100;
            maxValue = value + p;
          }
          if (value < minValue) {
            minValue = value;
          }
          sampleData.add(ChartSampleData(
              x: DateTime.parse(data.from!.keys.toList().reversed.toList()[i]),
              yValue: value));
        }
        setState(() {});
      } else {
        debugPrint("else");
      }
    } catch (e) {
      print("e--->$e");
    }
  }

  void chartData7Day({required String edtFrom, required String edtTo}) async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/$edtFrom/$edtTo/784565d2-9c14-4b25-8235-06f6c5029b15";
    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData data = ConverterData.fromMap(response.data);
        sampleData.clear();
        for (int i = 0; i <= 7; i++) {
          double value =
              (data.from!.values.toList().reversed.toList()[i] * 100) /
                  (data.to!.values.toList().reversed.toList()[i] * 100);
          if (i == 0) {
            maxValue = value;
            minValue = value;
          }
          if (value > maxValue) {
            double p = (value * 10) / 100;
            maxValue = value + p;
          }
          if (value < minValue) {
            minValue = value;
          }
          sampleData.add(ChartSampleData(
              x: DateTime.parse(data.from!.keys.toList().reversed.toList()[i]),
              yValue: value));
        }
        setState(() {});
      } else {
        debugPrint("else");
      }
    } catch (e) {
      print("e--->$e");
    }
  }

  void chartData30Day({required String edtFrom, required String edtTo}) async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/$edtFrom/$edtTo/784565d2-9c14-4b25-8235-06f6c5029b15";
    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData data = ConverterData.fromMap(response.data);
        sampleData.clear();
        for (int i = 0; i <= 30; i++) {
          double value =
              (data.from!.values.toList().reversed.toList()[i] * 100) /
                  (data.to!.values.toList().reversed.toList()[i] * 100);
          if (i == 0) {
            maxValue = value;
            minValue = value;
          }
          if (value > maxValue) {
            double p = (value * 10) / 100;
            maxValue = value + p;
          }
          if (value < minValue) {
            minValue = value;
          }
          sampleData.add(ChartSampleData(
              x: DateTime.parse(data.from!.keys.toList().reversed.toList()[i]),
              yValue: value));
        }
        setState(() {});
      } else {
        debugPrint("else");
      }
    } catch (e) {
      print("e--->$e");
    }
  }

  void chartData90Day({required String edtFrom, required String edtTo}) async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/$edtFrom/$edtTo/784565d2-9c14-4b25-8235-06f6c5029b15";
    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData data = ConverterData.fromMap(response.data);
        sampleData.clear();
        for (int i = 0; i <= 90; i++) {
          double value =
              (data.from!.values.toList().reversed.toList()[i] * 100) /
                  (data.to!.values.toList().reversed.toList()[i] * 100);
          if (i == 0) {
            maxValue = value;
            minValue = value;
          }
          if (value > maxValue) {
            double p = (value * 10) / 100;
            maxValue = value + p;
          }
          if (value < minValue) {
            minValue = value;
          }
          sampleData.add(ChartSampleData(
              x: DateTime.parse(data.from!.keys.toList().reversed.toList()[i]),
              yValue: value));
        }
        setState(() {});
      } else {
        debugPrint("else");
      }
    } catch (e) {
      print("e--->$e");
    }
  }

  void chartData1Year({required String edtFrom, required String edtTo}) async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/$edtFrom/$edtTo/784565d2-9c14-4b25-8235-06f6c5029b15";
    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData data = ConverterData.fromMap(response.data);
        sampleData.clear();
        for (int i = 0; i <= 356; i++) {
          print("data-->${data.from!.values.length}");
          double value =
              (data.from!.values.toList().reversed.toList()[i] * 100) /
                  (data.to!.values.toList().reversed.toList()[i] * 100);
          if (i == 0) {
            maxValue = value;
            minValue = value;
          }
          if (value > maxValue) {
            double p = (value * 10) / 100;
            maxValue = value + p;
          }
          if (value < minValue) {
            minValue = value;
          }
          sampleData.add(ChartSampleData(
              x: DateTime.parse(data.from!.keys.toList().reversed.toList()[i]),
              yValue: value));
        }
        setState(() {});
      } else {
        debugPrint("else");
      }
    } catch (e) {
      print("e--->$e");
    }
  }

  void chartDataAll({required String edtFrom, required String edtTo}) async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/$edtFrom/$edtTo/784565d2-9c14-4b25-8235-06f6c5029b15";
    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData data = ConverterData.fromMap(response.data);
        sampleData.clear();
        for (int i = 0; i < data.from!.values.length; i++) {
          double value = (data.from!.values.toList()[i] * 100) /
              (data.to!.values.toList()[i] * 100);
          if (i == 0) {
            maxValue = value;
            minValue = value;
          }
          if (value > maxValue) {
            double p = (value * 10) / 100;
            maxValue = value + p;
          }
          if (value < minValue) {
            minValue = value;
          }
          sampleData.add(ChartSampleData(
              x: DateTime.parse(data.from!.keys.toList()[i]), yValue: value));
        }
        setState(() {});
      } else {
        debugPrint("else");
      }
    } catch (e) {
      print("e--->$e");
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
}

class ChartSampleData {
  DateTime x;
  double yValue;
  ChartSampleData({required this.x, required this.yValue});
}
