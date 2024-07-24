import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CalorieTracking extends StatelessWidget {
  const CalorieTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NutritionalSummary(),
                SizedBox(height: 10),
                FoodEntrySection(
                  title: 'Breakfast',
                  calories: '272 kcal',
                  imagePath: 'assets/images/fruits.png',
                ),
                FoodEntrySection(
                  title: 'Lunch',
                  calories: '477 kcal',
                  imagePath: 'assets/images/lunch-bag.png',
                ),
                FoodEntrySection(
                  title: 'Dinner',
                  calories: '650 kcal',
                  imagePath: 'assets/images/dinner.png',
                ),
                SizedBox(height: 10),
                WaterTrackingSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NutritionalSummary extends StatelessWidget {
  const NutritionalSummary({super.key});

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
          children: [
            const Text(
              '1139 kcal left',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width / 2.5,
                lineWidth: 20.0,
                percent: 0.6,
                center: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NutritionalInfo(
                      label: 'Carbs',
                      value: '122 / 249 g',
                    ),
                    NutritionalInfo(
                      label: 'Protein',
                      value: '38 / 69 g',
                    ),
                    NutritionalInfo(
                      label: 'Fat',
                      value: '39 / 79 g',
                    ),
                  ],
                ),
                backgroundColor: Colors.grey[300]!,
                progressColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionalInfo extends StatelessWidget {
  final String label;
  final String value;

  const NutritionalInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class FoodEntrySection extends StatefulWidget {
  final String title;
  final String calories;
  final String imagePath;

  const FoodEntrySection({
    super.key,
    required this.title,
    required this.calories,
    required this.imagePath,
  });

  @override
  _FoodEntrySectionState createState() => _FoodEntrySectionState();
}

class _FoodEntrySectionState extends State<FoodEntrySection> {
  final List<String> _foodItems = [];
  bool _showMore = false;

  void _addFoodItem(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Add Food Item',
      message: 'Enter the food item below:',
      textFields: const [DialogTextField()],
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _foodItems.add(result.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsToShow = _showMore ? _foodItems : _foodItems.take(2).toList();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(widget.imagePath,
                width: 40, height: 40, fit: BoxFit.cover),
            title: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.calories),
                for (var item in itemsToShow) Text(item),
                if (_foodItems.length > 2 && !_showMore)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showMore = true;
                      });
                    },
                    child: const Text('Show more'),
                  ),
                if (_showMore && _foodItems.length > 2)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showMore = false;
                      });
                    },
                    child: const Text('Show less'),
                  ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addFoodItem(context),
            ),
          ),
        ],
      ),
    );
  }
}

class WaterTrackingSection extends StatefulWidget {
  const WaterTrackingSection({super.key});

  @override
  _WaterTrackingSectionState createState() => _WaterTrackingSectionState();
}

class _WaterTrackingSectionState extends State<WaterTrackingSection> {
  final int totalGlasses = 8;
  int filledGlasses = 0;
  bool showSaveButton = false;

  void _incrementGlasses() {
    if (filledGlasses < totalGlasses) {
      setState(() {
        filledGlasses++;
        showSaveButton = true;
      });
    }
  }

  void _toggleGlass(int index) {
    setState(() {
      if (index < filledGlasses) {
        filledGlasses--;
      } else {
        filledGlasses++;
      }
      showSaveButton = true;
    });
  }

  void _saveWaterIntake() {
    // Add your save logic here
    setState(() {
      showSaveButton = false;
    });
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
            const Center(
              child: Text(
                'Water Tracking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: totalGlasses,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _toggleGlass(index),
                  child: Image.asset(
                    'assets/images/water-bottle-${index < filledGlasses ? 'blue' : 'grey'}.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementGlasses,
                ),
                if (showSaveButton)
                  ElevatedButton(
                    onPressed: _saveWaterIntake,
                    child: const Text('Save'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
