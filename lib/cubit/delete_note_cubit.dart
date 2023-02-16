import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:todo_application/constants.dart';
import 'package:todo_application/cubit/common_state.dart';

class DeleteNoteCubit extends Cubit<CommonState> {
  DeleteNoteCubit() : super(CommonInitialState());

  deleteNotes({required String id}) async {
    try {
      emit(CommonLoadingState());
      final _dio = Dio();
      final response = await _dio.delete("${Constants.notes}/$id");
      if (response.statusCode == 200) {
        emit(CommonSuccessState());
      } else {
        emit(CommonErrorState(message: "Update to delete data"));
      }
    } on DioError catch (e) {
      emit(CommonErrorState(message: "Update to delete data"));
    } catch (e) {
      emit(CommonErrorState(message: "Update to delete data"));
    }
  }
}
