import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

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
  FoodEntrySectionState createState() => FoodEntrySectionState();
}

class FoodEntrySectionState extends State<FoodEntrySection> {
  final List<String> _foodItems = [];
  bool _showMore = false;

  void _addFoodItem(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Add Food Item',
      message: 'Enter the food item below:',
      textFields: const [DialogTextField()],
    );
    if (result != null && result.first.trim().isNotEmpty) {
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
