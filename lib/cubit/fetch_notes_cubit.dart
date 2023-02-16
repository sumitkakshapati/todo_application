import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/constants.dart';
import 'package:todo_application/cubit/common_state.dart';
import 'package:todo_application/cubit/delete_note_cubit.dart';
import 'package:todo_application/cubit/save_note_cubit.dart';
import 'package:todo_application/cubit/update_note_cubit.dart';
import 'package:todo_application/notes.dart';

class FetchNotesCubit extends Cubit<CommonState> {
  final SaveNoteCubit saveNoteCubit;
  StreamSubscription? saveNoteSubcription;

  final UpdateNoteCubit updateNoteCubit;
  StreamSubscription? updateNoteSubcription;

  final DeleteNoteCubit deleteNoteCubit;
  StreamSubscription? deleteNoteSubcription;

  FetchNotesCubit({
    required this.saveNoteCubit,
    required this.updateNoteCubit,
    required this.deleteNoteCubit,
  }) : super(CommonInitialState()) {
    saveNoteSubcription = saveNoteCubit.stream.listen((saveNoteState) {
      if (saveNoteState is CommonSuccessState) {
        fetchNotes();
      }
    });

    updateNoteSubcription = updateNoteCubit.stream.listen((saveNoteState) {
      if (saveNoteState is CommonSuccessState) {
        fetchNotes();
      }
    });

    deleteNoteSubcription = deleteNoteCubit.stream.listen((saveNoteState) {
      if (saveNoteState is CommonSuccessState) {
        fetchNotes();
      }
    });
  }

  fetchNotes() async {
    try {
      emit(CommonLoadingState());
      final dio = Dio();
      final response = await dio.get(Constants.notes);
      List item = List.from(response.data["data"]);
      final notes = item
          .map((e) => Notes(
              id: e["_id"], title: e["title"], description: e["description"]))
          .toList();
      emit(CommonSuccessState<List<Notes>>(data: notes));
    } catch (e) {
      emit(CommonErrorState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    saveNoteSubcription?.cancel();
    updateNoteSubcription?.cancel();
    deleteNoteSubcription?.cancel();
    return super.close();
  }
}
