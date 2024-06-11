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

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc() : super(const StatusState()) {
    on<StatusSelected>(_onStatusSelected);
  }

  void _onStatusSelected(StatusSelected event, Emitter<StatusState> emit) {
    emit(StatusState(selectedStatus: event.selectedStatus));
  }
}
