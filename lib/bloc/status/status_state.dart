// part of 'status_bloc.dart';
//
// @immutable
// sealed class StatusState {}
//
// final class StatusInitial extends StatusState {}

import 'package:equatable/equatable.dart';

abstract class DropdownState extends Equatable {
  const DropdownState();
}

class DropdownInitial extends DropdownState {
  @override
  List<Object> get props => [];
}

class DropdownItemSelectedState extends DropdownState {
  final String selectedItem;

  const DropdownItemSelectedState(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}