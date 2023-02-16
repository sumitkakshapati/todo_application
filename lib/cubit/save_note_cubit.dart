import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:todo_application/constants.dart';
import 'package:todo_application/cubit/common_state.dart';

class SaveNoteCubit extends Cubit<CommonState> {
  SaveNoteCubit() : super(CommonInitialState());

  saveNote({required String title, required String description}) async {
    try {
      emit(CommonLoadingState());
      final _dio = Dio();
      final _body = {
        "title": title,
        "description": description,
      };
      final response = await _dio.post(Constants.notes, data: _body);
      if (response.statusCode == 200) {
        emit(CommonSuccessState());
      } else {
        emit(CommonErrorState(message: "Unable to post data"));
      }
    } on DioError catch (e) {
      emit(CommonErrorState(message: "Unable to post data"));
    } catch (e) {
      emit(CommonErrorState(message: "Unable to post data"));
    }
  }
}
