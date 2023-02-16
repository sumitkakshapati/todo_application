import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:todo_application/cubit/common_state.dart';
import 'package:todo_application/cubit/save_note_cubit.dart';
import 'package:todo_application/cubit/update_note_cubit.dart';
import 'package:todo_application/notes.dart';

class AddNotesScreen extends StatefulWidget {
  final Notes? note;
  const AddNotesScreen({super.key, this.note});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SaveNoteCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  setState(() {
                    _isLoading = true;
                  });
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                }

                if (state is CommonSuccessState) {
                  Navigator.of(context).pop();
                } else if (state is CommonErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
            ),
            BlocListener<UpdateNoteCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  setState(() {
                    _isLoading = true;
                  });
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                }

                if (state is CommonSuccessState) {
                  Navigator.of(context).pop();
                } else if (state is CommonErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    labelText: "Title",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: 5,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Description",
                    labelText: "Description",
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    if (widget.note != null) {
                      context.read<UpdateNoteCubit>().updateNote(
                            id: widget.note!.id,
                            title: _titleController.text,
                            description: _descriptionController.text,
                          );
                    } else {
                      context.read<SaveNoteCubit>().saveNote(
                          title: _titleController.text,
                          description: _descriptionController.text);
                    }
                  },
                  child: Text(widget.note != null ? "Update" : "Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
