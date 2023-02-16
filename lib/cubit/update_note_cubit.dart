import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:todo_application/constants.dart';
import 'package:todo_application/cubit/common_state.dart';

class UpdateNoteCubit extends Cubit<CommonState> {
  UpdateNoteCubit() : super(CommonInitialState());

  updateNote({
    required String id,
    required String title,
    required String description,
  }) async {
    try {
      emit(CommonLoadingState());
      final _dio = Dio();
      final _body = {
        "title": title,
        "description": description,
      };
      final response = await _dio.put("${Constants.notes}/${id}", data: _body);
      if (response.statusCode == 200) {
        emit(CommonSuccessState());
      } else {
        emit(CommonErrorState(message: "Update to update data"));
      }
    } on DioError catch (e) {
      emit(CommonErrorState(message: "Update to update data"));
    } catch (e) {
      emit(CommonErrorState(message: "Update to update data"));
    }
  }
}
