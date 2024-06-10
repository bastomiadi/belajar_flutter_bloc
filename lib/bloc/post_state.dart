// part of 'post_bloc.dart';
//
// @immutable
// sealed class PostState {}
//
// final class PostInitial extends PostState {}

// lib/bloc/post_state.dart
import 'package:equatable/equatable.dart';
import '../models/post.dart';
abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<Post> posts;

  const PostLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}

class PostSubmissionSuccess extends PostState {
  @override
  List<Object> get props => [];
}

class PostSubmissionFailure extends PostState {
  final String message;

  const PostSubmissionFailure(this.message);

  @override
  List<Object> get props => [message];
}