import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:urinary_bladder_level/models/timeValueSpot.dart';
import 'package:urinary_bladder_level/provider/bladderProvider.dart';
class BladderGraph extends StatefulWidget {
  const BladderGraph({super.key});

  @override
  State<BladderGraph> createState() => _BladderGraphState();
}

class _BladderGraphState extends State<BladderGraph> {
  @override
  Widget build(BuildContext context) {
    final graphData = context.watch<BladderProvider>().graphData;
    for (var e in graphData) {
      if (!e.value.isFinite) {
        print('❌ Invalid point: ${e.time} => ${e.value}');
      }
    }
    return SfCartesianChart(
        plotAreaBorderWidth: 1,
        plotAreaBorderColor: Color(const Color.fromARGB(255, 0, 0, 0).value),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          zoomMode: ZoomMode.x,
        ),
        primaryXAxis: DateTimeAxis(
          axisLine: AxisLine(width: 0),
          title: AxisTitle(
            text: 'Time',
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),

          majorGridLines: MajorGridLines(width: 0),
          dateFormat: DateFormat('hh:mm a'),
          majorTickLines: MajorTickLines(size: 0),
          intervalType: DateTimeIntervalType.minutes,
          interval: 5,

          minimum: DateTime.now().subtract(Duration(minutes: 60)),
          maximum: DateTime.now(),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          borderWidth: 0,
          initialVisibleMinimum: DateTime.now().subtract(Duration(minutes: 10)),
          initialVisibleMaximum: DateTime.now(),
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          title: AxisTitle(
            text: 'Bladder Level (ml)',
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          majorTickLines: MajorTickLines(size: 0),
          majorGridLines: MajorGridLines(width: 0),
          minimum: 0,
          maximum: 2000,
          interval: 500,
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        series: <SplineSeries<TimeValueSpot, DateTime>>[
          SplineSeries<TimeValueSpot, DateTime>(
            color: const Color.fromARGB(255, 0, 102, 235),
            name: 'Bladder Level',
            enableTooltip: true,
            dataSource: graphData,
            xValueMapper: (data, _) => data.time,
            yValueMapper: (data, _) => data.value,

            // color: Colors.blue,
            animationDuration: 0,
            animationDelay: 0,
          ),
        ],
      );
  }
}