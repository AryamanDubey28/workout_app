import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/stress_tracking_pages/stress_summary.dart';
import 'package:workout_tracker/utilities/platform_specific_button.dart';

class StressGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StressGraph({super.key, this.animate = true})
      : seriesList = _createSampleData();

  static List<charts.Series<StressData, DateTime>> _createSampleData() {
    final data = [
      StressData(DateTime(2023, 7, 17), 1),
      StressData(DateTime(2023, 7, 18), 3),
      StressData(DateTime(2023, 7, 19), 2),
      StressData(DateTime(2023, 7, 20), 5),
      StressData(DateTime(2023, 7, 21), 4),
      StressData(DateTime(2023, 7, 22), 2),
      StressData(DateTime(2023, 7, 23), 3),
    ];

    return [
      charts.Series<StressData, DateTime>(
        id: 'Stress',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.purple), // Change to purple
        domainFn: (StressData stress, _) => stress.date,
        measureFn: (StressData stress, _) => stress.level,
        data: data,
        labelAccessorFn: (StressData stress, _) {
          switch (stress.level) {
            case 1:
              return '😊';
            case 2:
              return '🙂';
            case 3:
              return '😐';
            case 4:
              return '😟';
            case 5:
              return '😢';
            default:
              return '';
          }
        },
      ),
    ];
  }

  static double _calculateAverageStress(List<StressData> data) {
    if (data.isEmpty) return 0;
    final totalStress = data.fold(0, (sum, item) => sum + item.level);
    return totalStress / data.length;
  }

  @override
  Widget build(BuildContext context) {
    final data = [
      StressData(DateTime(2023, 7, 17), 1),
      StressData(DateTime(2023, 7, 18), 3),
      StressData(DateTime(2023, 7, 19), 2),
      StressData(DateTime(2023, 7, 20), 5),
      StressData(DateTime(2023, 7, 21), 4),
      StressData(DateTime(2023, 7, 22), 2),
      StressData(DateTime(2023, 7, 23), 3),
    ];

    final averageStress = _calculateAverageStress(data);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This Week',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200,
              child: charts.TimeSeriesChart(
                seriesList as List<charts.Series<dynamic, DateTime>>,
                animate: animate,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                defaultRenderer: charts.LineRendererConfig(
                  includeArea: true,
                  stacked: true,
                ),
                primaryMeasureAxis: const charts.NumericAxisSpec(
                  renderSpec: charts.NoneRenderSpec(),
                ),
                domainAxis: const charts.DateTimeAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 10,
                      color: charts.MaterialPalette.black,
                    ),
                    lineStyle: charts.LineStyleSpec(
                      thickness: 0,
                      color: charts.MaterialPalette.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Average this Week: ${averageStress.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: PlatformSpecificButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SummaryPage()),
                  );
                },
                child: const Text('See Summary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StressData {
  final DateTime date;
  final int level;

  StressData(this.date, this.level);
}
