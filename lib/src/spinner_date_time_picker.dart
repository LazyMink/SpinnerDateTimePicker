// import 'package:fernandes_b2b_flutter/helpers/pretty_log_output.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';

// var log = Logger(output: PrettyLogOutput());

class SpinnerDateTimePicker extends StatefulWidget {
  // static const String timePattern = "hh:mm aa";
  // static const String datePattern = "dd MMM yyyy";
  // static const String dateTimePattern = "dd MMM yyyy hh:mm aa";

  const SpinnerDateTimePicker({
    Key? key,
    // this.dialogTitle = "Title",
    // this.dialogMessage = "Description",
    required this.initialDateTime,
    required this.maximumDate,
    required this.minimumDate,
    this.use24hFormat = true,
    this.mode = CupertinoDatePickerMode.date,
    // this.didSelectDate,
    // this.formatPattern = dateTimePattern,
    required this.didSetTime
  }) : super(key: key);

  // final String formatPattern;
  //
  // final String dialogTitle;
  // final String dialogMessage;
  //
  // final Function(DateTime) didSelectDate;
  //

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
    if (widget.initialDateTime != null) {
      now = widget.initialDateTime;
    }

    initialDate = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );

    selectedDateTime = initialDate;

    if (widget.maximumDate == null) {
      maximumDate = initialDate.add(Duration(days: 7));
    } else {
      var max = widget.maximumDate;
      maximumDate = DateTime(
        max.year,
        max.month,
        max.day,
        max.hour,
        max.minute,
      );
    }

    if (widget.minimumDate == null) {
      minimumDate = initialDate;
    } else {
      var min = widget.minimumDate;
      minimumDate = DateTime(
        min.year,
        min.month,
        min.day,
        min.hour,
        min.minute,
      );
    }
  }

  // DateTime selectedDateTime;
  // String formattedDateTime;
  // String selectedPrefix = "";

  // void formatDateTime() {
  //
  //   String string = DateFormat(widget.formatPattern).format(selectedDateTime);
  //   setState(() {
  //     formattedDateTime = string;
  //   });
  // }

  // void setupPrefix() {
  //
  //   String prefix = "";
  //
  //   if (widget.mode == CupertinoDatePickerMode.date) {
  //     prefix = "Selected date:";
  //   }else if (widget.mode == CupertinoDatePickerMode.dateAndTime) {
  //     prefix = "Selected date and time:";
  //   }else if (widget.mode == CupertinoDatePickerMode.time){
  //     prefix = "Selected time:";
  //   }
  //
  //   setState(() {
  //     selectedPrefix = prefix;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    setupDateTime();

    // log.d("init: $initialDate min: $minimumDate max: $maximumDate");

    // setupPrefix();
    //
    // selectedDateTime = widget.initialDateTime;
    // formatDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: kIsWeb ? 320 : double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              // color: Colors.green,
              // padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   widget.dialogTitle,
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // widget.dialogMessage.isNotEmpty
                  //     ? Container(
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Text(
                  //         widget.dialogMessage,
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                  //     : Container(),
                  Container(
                    height: 200,
                    child: ScrollConfiguration(
                      behavior: kIsWeb
                          ? ScrollBehavior().copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                        },
                      )
                          : ScrollBehavior(),
                      child: CupertinoDatePicker(
                        initialDateTime: initialDate,
                        maximumDate: maximumDate,
                        minimumDate: minimumDate,
                        use24hFormat: widget.use24hFormat,
                        mode: widget.mode,
                        onDateTimeChanged: (dateTime) {
                          // log.d("onDateTimeChanged: $dateTime");
                          selectedDateTime = dateTime;
                          // formatDateTime();
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  // Text("$selectedPrefix"),
                  // SizedBox(height: 4,),
                  // Text("$formattedDateTime", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.all(16),
                            primary: Colors.grey,
                            // backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "CANCEL",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            // widget.didSelectDate(selectedDateTime);

                            if (widget.didSetTime != null) {
                              widget.didSetTime(selectedDateTime);
                            }
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.all(16),
                            primary: Colors.black,
                            // backgroundColor: kPrimaryDarkColor[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "SET TIME",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
