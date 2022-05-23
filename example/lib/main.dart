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
    return const MaterialApp(
      title: 'Flutter Example',
      home: MyHomePage(title: 'Example'),
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

  DateTime selectedDate = DateTime.now();

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
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    var today = DateTime.now();
                    return Dialog(
                      child: SpinnerDateTimePicker(
                        initialDateTime: today,
                        maximumDate: today.add(const Duration(days: 7)),
                        minimumDate: today.subtract(const Duration(days: 1)),
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
                child: const Text(
                  "Select Date & Time",
                ),
              ),
              SizedBox(height: 16,),
              const Text("Selected date:"),
              Text("$selectedDate", style: TextStyle(fontSize: 18),),
            ],
          ),
        ),
      ),
    );
  }
}
