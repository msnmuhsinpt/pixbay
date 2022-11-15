part of 'pixabay_bloc.dart';

abstract class ImageViewState extends Equatable {
  const ImageViewState();
}

class ImageViewInitialState extends ImageViewState {
  @override
  List<Object> get props => [];
}

class ImageViewLoadingState extends ImageViewState {
  @override
  List<Object> get props => [];
}

class ImageViewLoadedState extends ImageViewState {
  final ImageViewResponse response;

  const ImageViewLoadedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorState extends ImageViewState {
  const ErrorState();

  @override
  List<Object> get props => [];
}

class UnAuthorizedState extends ImageViewState {
  final String message;

  const UnAuthorizedState(this.message);

  @override
  List<Object?> get props => [
        message,
      ];
}

class NoInternetState extends ImageViewState {
  const NoInternetState();

  @override
  List<Object?> get props => [];
}
