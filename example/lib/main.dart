import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinner_date_time_picker/spinner_date_time_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      home: const MyHomePage(title: 'Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  var now = DateTime.now();
                  return Dialog(
                    child: SpinnerDateTimePicker(
                      initialDateTime: now,
                      maximumDate: now.add(Duration(days: 7)),
                      minimumDate: now.subtract(Duration(days: 1)),
                      mode: CupertinoDatePickerMode.dateAndTime,
                      use24hFormat: true,
                      didSetTime: (value) {
                        setState(() {
                          selectedDate = value;
                        });
                      },
                    ),
                  );
                });
              },
              child: Text(
                "Select Date & Time",
              ),
            ),
            Text("Selected date:"),
            Text("$selectedDate"),
          ],
        ),
      ),
    );
  }
}
