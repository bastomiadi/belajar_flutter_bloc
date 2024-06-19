import 'package:belajar_flutter_bloc/bloc/post/post_event.dart';
import 'package:belajar_flutter_bloc/bloc/status/status_event.dart';
import 'package:belajar_flutter_bloc/bloc/status/status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// import 'package:intl/intl.dart'; // For date formatting
import '../bloc/datepicker/datepicker_bloc.dart';
import '../bloc/datepicker/datepicker_event.dart';
import '../bloc/datepicker/datepicker_state.dart';
import '../bloc/post/post_bloc.dart';
import '../bloc/post/post_state.dart';
import '../bloc/status/status_bloc.dart';
import '../models/post.dart';
import '../utils/dialog.dart';

class PostFormScreen extends StatefulWidget {
  final Post? post;

  const PostFormScreen({super.key, this.post});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;
  late DateTime _date;
  late String _status;
  bool _isSubmitting = false;

  // final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = widget.post?.title ?? '';
    _body = widget.post?.body ?? '';
    // _date = widget.post!.date;
    // _status = widget.post?.status ?? 'Pending';
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final bool? confirm = await showConfirmationDialog(
        context,
        widget.post == null
            ? 'Do you want to create this post?'
            : 'Do you want to update this post?',
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
            //status: _status,
          );
          if (!mounted) return;
          context.read<PostBloc>().add(CreatePost(newPost));
        } else {
          // Update the existing post
          final updatedPost = Post(
            id: widget.post!.id,
            title: _title,
            body: _body,
            // date: _date,
            //.status: _status,
          );
          if (!mounted) return;
          context.read<PostBloc>().add(UpdatePost(updatedPost));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<DatePickerBloc>();

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
              SnackBar(
                  content: Text('Failed to submit post: ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BlocBuilder<DatePickerBloc, DatePickerState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: TextEditingController(
                        text:
                            DateFormat('yyyy-MM-dd').format(state.selectedDate),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Selected Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: state.selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null && picked != state.selectedDate) {
                          _bloc.add(DateChanged(picked));
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _date = DateTime.now();
                      // },
                    );
                  },
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
                BlocBuilder<DropdownBloc, DropdownState>(
                  builder: (context, state) {
                    String? selectedValue;
                    if (state is DropdownItemSelectedState) {
                      selectedValue = state.selectedItem;
                    }
                    return DropdownButtonFormField<String>(
                      value: selectedValue,
                      hint: const Text('Select an item'),
                      items: ['Item 1', 'Item 2', 'Item 3']
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<DropdownBloc>()
                              .add(DropdownItemSelected(value));
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an item';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _status = value!;
                      },
                    );
                  },
                ),
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
