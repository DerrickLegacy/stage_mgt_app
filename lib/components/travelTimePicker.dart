import 'package:flutter/material.dart';

class TravelTimePicker extends StatefulWidget {
  const TravelTimePicker({Key? key}) : super(key: key);

  @override
  _TravelTimePickerState createState() => _TravelTimePickerState();
}

class _TravelTimePickerState extends State<TravelTimePicker> {
  final TextEditingController _travelTimeController = TextEditingController();

  void _selectTime(BuildContext context) async {
    final TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTime != null) {
      // Show the second time picker for end time
      final TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: (startTime.hour + 1) % 24, // Default 1-hour difference
          minute: startTime.minute,
        ),
      );

      if (endTime != null) {
        // Format and display the time range in the TextField
        setState(() {
          _travelTimeController.text =
              "${startTime.format(context)} - ${endTime.format(context)}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        TextField(
          controller: _travelTimeController,
          decoration: const InputDecoration(
            labelText: "Travel Time",
            hintText: "E.g., 2:00 PM - 3:00 PM",
            prefixIcon: Icon(Icons.access_time),
            border: OutlineInputBorder(),
          ),
          readOnly: true, // Prevent manual typing
          onTap: () => _selectTime(context), // Trigger time picker on tap
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
