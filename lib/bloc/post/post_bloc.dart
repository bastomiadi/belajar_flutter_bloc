// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'post_event.dart';
// part 'post_state.dart';
//
// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc() : super(PostInitial()) {
//     on<PostEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  void _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await postRepository.fetchPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await postRepository.createPost(event.post);
      emit(PostSubmissionSuccess());
      add(FetchPosts()); // Refresh the list of posts
    } catch (e) {
      emit(PostSubmissionFailure(e.toString()));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await postRepository.updatePost(event.post);
      emit(PostSubmissionSuccess());
      add(FetchPosts()); // Refresh the list of posts
    } catch (e) {
      emit(PostSubmissionFailure(e.toString()));
    }
  }

  void _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await postRepository.deletePost(event.id);
      emit(PostSubmissionSuccess());
      add(FetchPosts()); // Refresh the list of posts
    } catch (e) {
      emit(PostSubmissionFailure(e.toString()));
    }
  }
}


