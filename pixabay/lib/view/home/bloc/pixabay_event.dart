part of 'pixabay_bloc.dart';

abstract class ImageViewEvent extends Equatable {
  const ImageViewEvent();
}

class ImageViewApiEvent extends ImageViewEvent {
  const ImageViewApiEvent();

  @override
  List<Object?> get props => [];
}
