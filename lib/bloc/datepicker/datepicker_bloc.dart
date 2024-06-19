// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'datepicker_event.dart';
// part 'datepicker_state.dart';
//
// class DatepickerBloc extends Bloc<DatepickerEvent, DatepickerState> {
//   DatepickerBloc() : super(DatepickerInitial()) {
//     on<DatepickerEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

// datepicker_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'datepicker_event.dart';
import 'datepicker_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerState(selectedDate: DateTime.now())) {
    on<DateChanged>((event, emit) {
      emit(DatePickerState(selectedDate: event.date));
    });
  }
}



