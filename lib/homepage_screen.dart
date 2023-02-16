import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_application/add_note_screen.dart';
import 'package:todo_application/cubit/common_state.dart';
import 'package:todo_application/cubit/delete_note_cubit.dart';
import 'package:todo_application/cubit/fetch_notes_cubit.dart';
import 'package:todo_application/notes.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<FetchNotesCubit>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).push(
              PageTransition(
                child: AddNotesScreen(),
                type: PageTransitionType.fade,
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: BlocListener<DeleteNoteCubit, CommonState>(
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Note deleted successfully"),
                ),
              );
            } else if (state is CommonErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<FetchNotesCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CommonSuccessState<List<Notes>> && state.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: UniqueKey(),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) async {
                              context.read<DeleteNoteCubit>().deleteNotes(
                                    id: state.data![index].id,
                                  );
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(state.data![index].title),
                        subtitle: Text(state.data![index].description),
                        onTap: () async {
                          final _result = await Navigator.of(context).push(
                            PageTransition(
                              child: AddNotesScreen(note: state.data![index]),
                              type: PageTransitionType.fade,
                            ),
                          );
                          if (_result == true) {
                            setState(() {});
                          }
                        },
                      ),
                    );
                  },
                  itemCount: state.data!.length,
                );
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
