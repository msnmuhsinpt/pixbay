import 'package:equatable/equatable.dart';
import 'package:pixabay/api/api_model/pixabar_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/api_service/api_service.dart';

part 'pixabay_event.dart';

part 'pixabay_state.dart';

class ImageViewBloc extends Bloc<ImageViewEvent, ImageViewState> {
  final APIService _apiService;

  ImageViewBloc(this._apiService) : super(ImageViewInitialState()) {
    on<ImageViewApiEvent>((event, emit) async {
      emit(ImageViewLoadingState());
      final response = await _apiService.getData();
      if (response.code == 500) {
        emit(const ErrorState());
      } else if (response.code == 200) {
        emit(const NoInternetState());
      } else {
        emit(ImageViewLoadedState(response));
      }
    });
  }
}
