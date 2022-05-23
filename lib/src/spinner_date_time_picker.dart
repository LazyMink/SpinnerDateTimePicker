import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SpinnerDateTimePicker extends StatefulWidget {
  const SpinnerDateTimePicker({
    Key? key,
    required this.initialDateTime,
    required this.maximumDate,
    required this.minimumDate,
    this.use24hFormat = true,
    this.mode = CupertinoDatePickerMode.date,
    required this.didSetTime,
  }) : super(key: key);

  final Function(DateTime) didSetTime;

  final DateTime initialDateTime;

  final DateTime maximumDate;
  final DateTime minimumDate;
  final bool use24hFormat;
  final CupertinoDatePickerMode mode;

  @override
  State<SpinnerDateTimePicker> createState() => _SpinnerDateTimePickerState();
}

class _SpinnerDateTimePickerState extends State<SpinnerDateTimePicker> {
  late DateTime initialDate;
  late DateTime maximumDate;
  late DateTime minimumDate;

  late DateTime selectedDateTime;

  void setupDateTime() {
    DateTime now = DateTime.now();
    now = widget.initialDateTime;

    initialDate = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );

    selectedDateTime = initialDate;

    var max = widget.maximumDate;
    maximumDate = DateTime(
      max.year,
      max.month,
      max.day,
      max.hour,
      max.minute,
    );

    var min = widget.minimumDate;
    minimumDate = DateTime(
      min.year,
      min.month,
      min.day,
      min.hour,
      min.minute,
    );
  }

  @override
  void initState() {
    super.initState();

    setupDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kIsWeb ? 320 : double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: ScrollConfiguration(
                    behavior: kIsWeb
                        ? const ScrollBehavior().copyWith(
                            dragDevices: {
                              PointerDeviceKind.mouse,
                            },
                          )
                        : const ScrollBehavior(),
                    child: CupertinoDatePicker(
                      initialDateTime: initialDate,
                      maximumDate: maximumDate,
                      minimumDate: minimumDate,
                      use24hFormat: widget.use24hFormat,
                      mode: widget.mode,
                      onDateTimeChanged: (dateTime) {
                        selectedDateTime = dateTime;
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(16),
                        primary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        widget.didSetTime(selectedDateTime);
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(16),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "SET TIME",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
