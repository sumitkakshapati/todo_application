abstract class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonSuccessState<T> extends CommonState {
  final T? data;
  CommonSuccessState({this.data});
}

class CommonErrorState extends CommonState {
  final String message;
  CommonErrorState({
    required this.message,
  });
}
