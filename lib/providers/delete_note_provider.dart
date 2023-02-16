// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_application/constants.dart';

// class DeleteNoteProvider extends ChangeNotifier {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   Future<bool> delete({
//     required String id,
//     required BuildContext context,
//   }) async {
//     bool isSuccess = false;
//     try {
//       _isLoading = true;
//       notifyListeners();
//       final _dio = Dio();
//       final response = await _dio.delete("${Constants.notes}/$id");
//       if (response.statusCode == 200) {
//         isSuccess = true;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("note deleted successfully")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Unable to delete data")),
//         );
//       }
//     } on DioError catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to delete data")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to delete data")),
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//       return isSuccess;
//     }
//   }
// }
