// part of 'post_bloc.dart';
//
// @immutable
// sealed class PostEvent {}
//

// lib/bloc/post_event.dart
import 'package:equatable/equatable.dart';

import '../../models/post.dart';
abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchPosts extends PostEvent {
  @override
  List<Object> get props => [];
}

class CreatePost extends PostEvent {
  final Post post;

  const CreatePost(this.post);

  @override
  List<Object> get props => [post];
}

class UpdatePost extends PostEvent {
  final Post post;

  const UpdatePost(this.post);

  @override
  List<Object> get props => [post];
}

class DeletePost extends PostEvent {
  final int id;

  const DeletePost(this.id);

  @override
  List<Object> get props => [id];
}