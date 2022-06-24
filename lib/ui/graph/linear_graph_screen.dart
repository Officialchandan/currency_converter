import 'dart:developer';

import 'package:currency_converter/Models/converter_data.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinearGraphScreen extends StatefulWidget {
  const LinearGraphScreen({Key? key}) : super(key: key);

  @override
  _LinearGraphScreenState createState() => _LinearGraphScreenState();
}

class _LinearGraphScreenState extends State<LinearGraphScreen> {
  late ZoomPanBehavior _zoomPanBehavior;
  String from = "";
  String to = '';
  TrackballBehavior? _trackballBehavior;
  double maxValue = 100;
  double minValue = 0;
  double interval = 5;

  List<ChartSampleData> cartData = [];

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        // Enables pinch zooming
        zoomMode: ZoomMode.x,
        enablePinching: true,
        enablePanning: true);
    _trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y', borderWidth: 0));
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          MyColors.colorPrimary.withOpacity(0.6),
          MyColors.colorPrimary.withOpacity(1.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                color: const Color.fromRGBO(38, 38, 38, 1),
                child: SfCartesianChart(
                    zoomPanBehavior: ZoomPanBehavior(
                        // Enables pinch zooming
                        zoomMode: ZoomMode.x,
                        enablePinching: true,
                        enablePanning: true),
                    plotAreaBorderWidth: 0,
                    title: ChartTitle(text: "$from to $to exchange rate"),
                    primaryXAxis: DateTimeAxis(
                        majorGridLines: const MajorGridLines(width: 1),
                        dateFormat: DateFormat("MMM-yyyy"),
                        labelStyle: const TextStyle(color: Colors.white),
                        edgeLabelPlacement: EdgeLabelPlacement.shift),
                    primaryYAxis: NumericAxis(
                        minimum: minValue,
                        maximum: maxValue,
                        interval: interval,
                        enableAutoIntervalOnZooming: true,
                        autoScrollingMode: AutoScrollingMode.end,
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        labelAlignment: LabelAlignment.center,
                        labelPosition: ChartDataLabelPosition.outside,
                        labelStyle: const TextStyle(color: Colors.white),
                        anchorRangeToVisiblePoints: false,
                        associatedAxisName: "axis name",
                        decimalPlaces: minValue < 1 ? 3 : 0,
                        placeLabelsNearAxisLine: true,
                        zoomFactor: 10,

                        // labelFormat: r'${value}',
                        // title: AxisTitle(text: "$to"),
                        axisLine: const AxisLine(width: 1),
                        majorTickLines: const MajorTickLines(size: 0)),
                    tooltipBehavior: TooltipBehavior(
                      tooltipPosition: TooltipPosition.pointer,
                    ),
                    series: getDefaultDateTime(),
                    trackballBehavior: _trackballBehavior),
                // primaryYAxis: DateTimeAxis(maj),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getData() async {
    from = await Utility.getStringPreference(Constants.currencyCodeFrom);
    if (from.isEmpty) {
      from = "USD";
    }
    to = await Utility.getStringPreference(Constants.currencyCodeTo);
    if (to.isEmpty) {
      from = "EUR";
    }
    log("from-->$from");
    log("to-->$to");
    Response res = await Dio().get("https://www.currency.wiki/api/currency/quotes/$from/$to/784565d2-9c14-4b25-8235-06f6c5029b15");

    ConverterData data = ConverterData.fromJson(res.toString());

    // List<Map<String, dynamic>> formRow = await dbHelper.particular_row(from);
    // List<Map<String, dynamic>> toRow = await dbHelper.particular_row(to);

    log("from_row-->${data.from!.length}");
    log("toRow-->${data.to!.length}");
    try {
      if (data.from != null && data.to != null) {
        // data.to!.forEach((key, value) {
        //   double values = (data.from!.values.first * 100) / (value * 100);
        //   ChartSampleData sampleData = ChartSampleData(x: DateTime.parse(key), yValue: values);
        //   cartData.add(sampleData);
        // });

        if (data.from!.length < data.to!.length) {
          for (int i = 0; i < data.from!.length; i++) {
            double value = (data.from!.values.toList()[i] * 100) / (data.to!.values.toList()[i] * 100);
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
            cartData.add(ChartSampleData(x: DateTime.parse(data.from!.keys.toList()[i]), yValue: value));
          }
        } else {
          for (int i = 0; i < data.to!.length; i++) {
            double value = (data.from!.values.toList()[i] * 100) / (data.to!.values.toList()[i] * 100);
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

            cartData.add(ChartSampleData(x: DateTime.parse(data.from!.keys.toList()[i]), yValue: value));
          }
        }
      }

      if (maxValue < 1) {
      } else {
        minValue = minValue.floorToDouble();
        maxValue = maxValue.ceilToDouble();
      }

      interval = (maxValue - minValue) / 5;
    } catch (exception) {
      debugPrint("exception-->$exception");
    }

    debugPrint("chartdata-->$cartData");

    setState(() {});
  }

  List<LineSeries<ChartSampleData, DateTime>> getDefaultDateTime() {
    return <LineSeries<ChartSampleData, DateTime>>[
      LineSeries<ChartSampleData, DateTime>(
          dataSource: cartData,
          xValueMapper: (ChartSampleData data, _) {
            try {
              return data.x as DateTime;
            } catch (exception) {
              return DateTime.now();
            }
          },
          yValueMapper: (ChartSampleData data, _) => data.yValue,
          color: MyColors.colorPrimary)
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

/// Chart Sales Data
class SalesData {
  /// Holds the datapoint values like x, y, etc.,
  SalesData(this.x, this.y, [this.date, this.color]);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}
