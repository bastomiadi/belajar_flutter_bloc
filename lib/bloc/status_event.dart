// part of 'status_bloc.dart';
//
// @immutable
// sealed class StatusEvent {}

import 'package:equatable/equatable.dart';

abstract class StatusEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatusSelected extends StatusEvent {
  final String selectedStatus;

  StatusSelected(this.selectedStatus);

  @override
  List<Object?> get props => [selectedStatus];
}