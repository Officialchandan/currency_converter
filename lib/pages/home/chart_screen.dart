import 'package:currency_converter/widget/add_screen_widget.dart';
import 'package:dio/dio.dart';
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
    chartData(edtFrom: widget.textFrom, edtTo: widget.textTo);
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = MediaQuery.of(context).size.height;
    var appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Text(widget.textFrom + "/" + widget.textTo + " " + "Charts",
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
            top: appHeight * 0.04,
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
                  majorGridLines: MajorGridLines(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffe2e2e2)),
                  axisLine: AxisLine(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffe2e2e2)),
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
                  majorGridLines: MajorGridLines(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffe2e2e2)),
                  axisLine: AxisLine(
                      color: MyColors.isDarkMode
                          ? const Color(0xff505050)
                          : const Color(0xffe2e2e2)),
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
              top: appHeight * 0.460,
              right: 0,
              left: 0,
              child: const AddScreenWidget()),
          sampleData.isEmpty
              ? Positioned(
                  top: appHeight * 0.18,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.colorPrimary,
                    ),
                  ),
                )
              : Container(),
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

  void chartData({required String edtFrom, required String edtTo}) async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/$edtFrom/$edtTo/784565d2-9c14-4b25-8235-06f6c5029b15";
    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        ConverterData data = ConverterData.fromMap(response.data);
        for (int i = 0; i < data.from!.length; i++) {
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
}

class ChartSampleData {
  DateTime x;
  double yValue;
  ChartSampleData({required this.x, required this.yValue});
}
