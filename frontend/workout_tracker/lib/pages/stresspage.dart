import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class StressTracking extends StatelessWidget {
  const StressTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StressGraph(),
                const SizedBox(height: 20),
                MeditationCard(),
                const SizedBox(height: 20),
                const JournalCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
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

  @override
  Widget build(BuildContext context) {
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
              'Stress Levels Over the Week',
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

class MeditationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MeditationPage()),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meditation and Breathing Exercises',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Find time to relax and unwind with these guided meditations and breathing exercises.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation and Breathing Exercises'),
      ),
      body: const Center(
        child: Text('Dummy Text'),
      ),
    );
  }
}

class JournalCard extends StatelessWidget {
  const JournalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Journal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Record your thoughts and feelings in your journal.',
            ),
            const SizedBox(height: 10),
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: const AddJournalEntryPage(),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ViewAllJournalEntriesPage()),
                  );
                },
                child: const Text('See All'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddJournalEntryPage extends StatelessWidget {
  const AddJournalEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add save logic here
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.indigo,
              ),
              child: const Text('Done'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Write your thoughts here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewAllJournalEntriesPage extends StatelessWidget {
  const ViewAllJournalEntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Journal Entries'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: 10, // Replace with actual count of journal entries
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Journal Entry ${index + 1}'),
                subtitle: Text('Sample text for journal entry ${index + 1}...'),
              );
            },
          ),
        ),
      ),
    );
  }
}
