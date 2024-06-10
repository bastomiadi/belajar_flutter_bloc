// part of 'status_bloc.dart';
//
// @immutable
// sealed class StatusState {}
//
// final class StatusInitial extends StatusState {}

import 'package:equatable/equatable.dart';

class StatusState extends Equatable {
  final String? selectedStatus;

  StatusState({this.selectedStatus});

  @override
  List<Object?> get props => [selectedStatus ?? ''];
}