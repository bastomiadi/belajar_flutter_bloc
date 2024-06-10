// part of 'datepicker_bloc.dart';
//
// @immutable
// sealed class DatepickerEvent {}

// datepicker_event.dart
abstract class DatePickerEvent {}

class SelectDate extends DatePickerEvent {
  final DateTime selectedDate;

  SelectDate(this.selectedDate);
}