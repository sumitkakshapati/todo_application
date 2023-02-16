// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_application/constants.dart';

// class AddNoteProvider extends ChangeNotifier {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   Future<bool> saveNotes({
//     required String title,
//     required String description,
//     required BuildContext context,
//   }) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//       final _dio = Dio();
//       final _body = {
//         "title": title,
//         "description": description,
//       };
//       final response = await _dio.post(Constants.notes, data: _body);
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("note added successfully")),
//         );
//         return true;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Unable to post data")),
//         );
//         return false;
//       }
//     } on DioError catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to post data")),
//       );
//       return false;
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to post data")),
//       );
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
