// part of 'datepicker_bloc.dart';
//
// @immutable
// sealed class DatepickerEvent {}

// datepicker_event.dart
abstract class DatePickerEvent {}

class DateChanged extends DatePickerEvent {
  final DateTime date;

  DateChanged(this.date);
}

