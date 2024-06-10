// part of 'datepicker_bloc.dart';
//
// @immutable
// sealed class DatepickerState {}
//
// final class DatepickerInitial extends DatepickerState {}

// datepicker_state.dart
abstract class DatePickerState {}

class DatePickerInitial extends DatePickerState {
  final DateTime initialDate;

  DatePickerInitial(this.initialDate);
}

class DatePickerSelected extends DatePickerState {
  final DateTime selectedDate;

  DatePickerSelected(this.selectedDate);
}