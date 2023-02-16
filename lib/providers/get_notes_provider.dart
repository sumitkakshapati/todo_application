import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/notes.dart';

import '../constants.dart';

class GetNotesProvider extends ChangeNotifier {
  List<Notes> _notes = [];

  List<Notes> get notes => _notes;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _message = "";

  String get message => _message;

  fetchNotes() async {
    try {
      _isLoading = true;
      notifyListeners();
      final dio = Dio();
      final response = await dio.get(Constants.notes);
      List item = List.from(response.data["data"]);
      _notes = item
          .map((e) => Notes(
              id: e["_id"], title: e["title"], description: e["description"]))
          .toList();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
