<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This is a very simple spinner date picker, that i often use projects.

## Features

- Set initial date time.
- Set minimum date date.
- Set maximum date date.
- Set picker type. date, time or date&time.
- Set 24h true/false.
- Set time callback.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

You can use it to make a dialog.

```dart
showDialog(
  context: context,
  builder: (context) {
    var now = DateTime.now();
    return Dialog(
      child: SpinnerDateTimePicker(
        initialDateTime: now,
        maximumDate: now.add(Duration(days: 7)),
        minimumDate: now.subtract(Duration(days: 1)),
        mode: CupertinoDatePickerMode.dateAndTime,
        use24hFormat: true,
        didSetTime: (value) {
          log.d("did set time: $value");
        },
      ),
    );
  },
);
```

## Additional information

Nothing for now. Let me know if i missed anything i need to add.
