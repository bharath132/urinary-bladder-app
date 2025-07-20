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
    if (graphData.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    // Check for invalid data points
    if (graphData.any((e) => e.value.isNaN || e.value.isInfinite)) {
      return const Center(
        child: Text(
          'Invalid data points detected',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
    // Log valid and invalid points
    for (var e in graphData) {
      if (e.value.isFinite) {
        print('✅ Valid point: ${e.time} => ${e.value}');
      }
    }
    
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
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          format: 'Time: {point.x}\nBladder Level: {point.y} ml',
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
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
        title: ChartTitle(
          text: 'Bladder Level Over Time',
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
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
            markerSettings: const MarkerSettings(
              isVisible: false,
              color: Color.fromARGB(255, 0, 102, 235),
              borderColor: Colors.white,
              borderWidth: 5,
            ),
            // color: Colors.blue,
            animationDuration: 0,
            animationDelay: 0,
          ),
        ],
      );
  }
}