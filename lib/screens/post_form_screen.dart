import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart'; // For date formatting
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../models/post.dart';
import '../utils/dialog.dart';

class PostFormScreen extends StatefulWidget {
  final Post? post;

  const PostFormScreen({super.key, this.post});

  @override
  _PostFormScreenState createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;
  late DateTime _date;
  late String _status;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _title = widget.post?.title ?? '';
    _body = widget.post?.body ?? '';
    // _date = widget.post?.date ?? DateTime.now();
    // _status = widget.post?.status ?? 'Pending';
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final bool? confirm = await showConfirmationDialog(
        context,
        widget.post == null ? 'Do you want to create this post?' : 'Do you want to update this post?',
      );

      if (confirm == true) {
        _formKey.currentState!.save();

        setState(() {
          _isSubmitting = true;
        });

        if (widget.post == null) {
          // Create a new post
          final newPost = Post(
            id: 0,
            title: _title,
            body: _body,
            // date: _date,
            // status: _status,
          );
          context.read<PostBloc>().add(CreatePost(newPost));
        } else {
          // Update the existing post
          final updatedPost = Post(
            id: widget.post!.id,
            title: _title,
            body: _body,
            // date: _date,
            // status: _status,
          );
          context.read<PostBloc>().add(UpdatePost(updatedPost));
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Create Post' : 'Update Post'),
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostSubmissionSuccess) {
            setState(() {
              _isSubmitting = false;
            });
            Navigator.pop(context);
          } else if (state is PostSubmissionFailure) {
            setState(() {
              _isSubmitting = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to submit post: ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                ),
                TextFormField(
                  initialValue: _body,
                  decoration: const InputDecoration(labelText: 'Body'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a body';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _body = value!;
                  },
                ),
                // SizedBox(height: 16.0),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Text(
                //         'Date: ${DateFormat.yMd().format(_date)}',
                //       ),
                //     ),
                //     ElevatedButton(
                //       onPressed: () => _selectDate(context),
                //       child: Text('Select date'),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 16.0),
                // DropdownButtonFormField<String>(
                //   value: _status,
                //   items: ['Pending', 'Completed']
                //       .map((status) => DropdownMenuItem(
                //     value: status,
                //     child: Text(status),
                //   ))
                //       .toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       _status = value!;
                //     });
                //   },
                //   decoration: InputDecoration(labelText: 'Status'),
                // ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  child: _isSubmitting
                      ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : Text(widget.post == null ? 'Create' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
