import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<Widget> items;
  final Color backgroundColor;
  final Color iconColor;
  final Color selectedIconColor;

  CustomNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.selectedIconColor = Colors.blue,
  });

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.items.asMap().entries.map((entry) {
          int index = entry.key;
          Widget icon = entry.value;
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
                top: isSelected ? 0 : 12,
                bottom: isSelected ? 12 : 0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? widget.selectedIconColor.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: IconTheme(
                data: IconThemeData(
                  color:
                      isSelected ? widget.selectedIconColor : widget.iconColor,
                ),
                child: icon,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
