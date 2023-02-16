// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_application/constants.dart';

// class UpdateNoteProvider extends ChangeNotifier {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   Future<bool> update({
//     required String id,
//     required String title,
//     required String description,
//     required BuildContext context,
//   }) async {
//     bool isSuccess = false;
//     try {
//       _isLoading = true;
//       notifyListeners();
//       final _dio = Dio();
//       final _body = {
//         "title": title,
//         "description": description,
//       };
//       final response = await _dio.put("${Constants.notes}/${id}", data: _body);
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("note updated successfully")),
//         );
//         isSuccess = true;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Unable to update data")),
//         );
//       }
//     } on DioError catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to update data")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to update data")),
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//       return isSuccess;
//     }
//   }
// }
