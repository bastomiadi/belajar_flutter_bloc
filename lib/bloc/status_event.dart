// part of 'status_bloc.dart';
//
// @immutable
// sealed class StatusEvent {}

import 'package:equatable/equatable.dart';

abstract class DropdownEvent extends Equatable {
  const DropdownEvent();
}

class DropdownItemSelected extends DropdownEvent {
  final String selectedItem;

  const DropdownItemSelected(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}