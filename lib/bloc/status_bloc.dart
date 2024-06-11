// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'status_event.dart';
// part 'status_state.dart';
//
// class StatusBloc extends Bloc<StatusEvent, StatusState> {
//   StatusBloc() : super(StatusInitial()) {
//     on<StatusEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'status_event.dart';
import 'status_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial()) {
    // Register the event handler
    on<DropdownItemSelected>(_onDropdownItemSelected);
  }

  void _onDropdownItemSelected(DropdownItemSelected event, Emitter<DropdownState> emit) {
    emit(DropdownItemSelectedState(event.selectedItem));
  }
}
