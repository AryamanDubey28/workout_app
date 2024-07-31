import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCards extends StatefulWidget {
  final String title;
  const DateCards({super.key, required this.title});

  @override
  State<DateCards> createState() => _DateCardsState();
}

class _DateCardsState extends State<DateCards> {
  DateTime today = DateTime.now();
  late DateTime weekStart;

  @override
  void initState() {
    super.initState();
    weekStart = today.subtract(Duration(days: today.weekday - 1));
  }

  void _updateWeekDates(int days) {
    setState(() {
      weekStart = weekStart.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dayFormatter = DateFormat('EEE');
    final DateFormat numericDayFormatter = DateFormat('d');
    final List<DateTime> weekDays =
        List.generate(5, (index) => weekStart.add(Duration(days: index)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {}, // Placeholder for calendar icon action
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
              child: TextButton(
                onPressed: () => _updateWeekDates(-5),
                child: const Text('<',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.primaryDelta != null &&
                      details.primaryDelta! > 0) {
                    _updateWeekDates(-5);
                  } else if (details.primaryDelta != null &&
                      details.primaryDelta! < 0) {
                    _updateWeekDates(5);
                  }
                },
                child: SizedBox(
                  height: 70,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: weekDays.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      bool isToday = weekDays[index].day == today.day &&
                          weekDays[index].month == today.month &&
                          weekDays[index].year == today.year;
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              color:
                                  isToday ? Colors.black : Colors.transparent,
                              width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                numericDayFormatter.format(weekDays[index]),
                                style: TextStyle(
                                    color:
                                        isToday ? Colors.black : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                dayFormatter.format(weekDays[index]),
                                style: TextStyle(
                                    color:
                                        isToday ? Colors.black : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: TextButton(
                onPressed: () => _updateWeekDates(5),
                child: const Text('>',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
