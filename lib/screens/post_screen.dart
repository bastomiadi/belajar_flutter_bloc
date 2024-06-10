// lib/screens/post_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../utils/dialog.dart';
import '../widgets/shimmer_post_list.dart';
import 'post_form_screen.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return ShimmerPostList();
            // return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostFormScreen(post: post),
                            ),
                          );
                        },
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () {
                      //     context.read<PostBloc>().add(DeletePost(post.id));
                      //   },
                      // ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          // print('sssss');
                          final bool? confirm = await showConfirmationDialog(
                            context,
                            'Do you want to delete this post?',
                          );
                          if (confirm == true) {
                            if (!context.mounted) return;
                            context.read<PostBloc>().add(DeletePost(post.id));
                          }
                        },
                      )
                    ],
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(
                child: Text('Failed to load posts: ${state.message}'));
          } else {
            return const Center(child: Text('No posts'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
