// ignore_for_file: unused_field
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<String> items;
  final List<Color> selectedIconColors; // New parameter
  final Color backgroundColor;
  final Color iconColor;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
    required this.selectedIconColors,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  CustomNavigationBarState createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void didUpdateWidget(CustomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.items.map((item) {
          int index = widget.items.indexOf(item);
          bool isSelected = widget.selectedIndex == index;
          return GestureDetector(
            onTap: () {
              widget.onTap(index);
              _controller.forward(from: 0.0);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(
                top: isSelected ? 0 : 10,
                bottom: isSelected ? 10 : 0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? widget.selectedIconColors[index].withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: Image.asset(
                item,
                color: isSelected
                    ? widget.selectedIconColors[index]
                    : widget.iconColor,
                height: 25,
                width: 25,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
