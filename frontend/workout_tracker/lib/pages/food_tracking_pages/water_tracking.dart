import 'package:flutter/material.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Water Tracking',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementGlasses,
                ),
              ],
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
            const Divider(
              color: Colors.grey,
              thickness: 0.7,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/water-bottle-blue.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '= 250ml',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
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
