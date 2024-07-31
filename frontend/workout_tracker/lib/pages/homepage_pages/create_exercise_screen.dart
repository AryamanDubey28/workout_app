import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/utilities/platform_specific_button.dart';

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({super.key});

  @override
  _CreateExerciseScreenState createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  final TextEditingController _exerciseNameController = TextEditingController();
  final Set<String> _selectedMuscles = {};

  final List<Map<String, String>> _muscleGroups = [
    {'name': 'Chest', 'image': 'assets/images/muscle_groups/chest.png'},
    {'name': 'Triceps', 'image': 'assets/images/muscle_groups/triceps.png'},
    {'name': 'Shoulders', 'image': 'assets/images/muscle_groups/shoulders.png'},
    {'name': 'Biceps', 'image': 'assets/images/muscle_groups/biceps.png'},
    {'name': 'Back', 'image': 'assets/images/muscle_groups/back.png'},
    {'name': 'Forearms', 'image': 'assets/images/muscle_groups/forearms.png'},
    {'name': 'Abs', 'image': 'assets/images/muscle_groups/abs.png'},
    {'name': 'Quads', 'image': 'assets/images/muscle_groups/quads.png'},
    {
      'name': 'Hamstrings',
      'image': 'assets/images/muscle_groups/hamstrings.png'
    },
    {'name': 'Calves', 'image': 'assets/images/muscle_groups/calf.png'},
  ];

  void _toggleSelection(String muscle) {
    setState(() {
      if (_selectedMuscles.contains(muscle)) {
        _selectedMuscles.remove(muscle);
      } else {
        _selectedMuscles.add(muscle);
      }
    });
  }

  void _saveExercise() {
    if (_selectedMuscles.isNotEmpty &&
        _exerciseNameController.text.isNotEmpty) {
      Navigator.pop(context, 'Exercise Saved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _exerciseNameController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
              onChanged: (text) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Muscle Groups Worked',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.8, // More rectangular aspect ratio
                ),
                itemCount: _muscleGroups.length,
                itemBuilder: (context, index) {
                  final muscle = _muscleGroups[index];
                  final isSelected = _selectedMuscles.contains(muscle['name']);
                  return GestureDetector(
                    onTap: () => _toggleSelection(muscle['name']!),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: isSelected ? Colors.green : Colors.grey,
                          width: 4.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                muscle['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              muscle['name']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            PlatformSpecificButton(
              color: CupertinoColors.systemGreen,
              onPressed: _selectedMuscles.isNotEmpty &&
                      _exerciseNameController.text.isNotEmpty
                  ? _saveExercise
                  : null,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
