part of 'pixabay_bloc.dart';

abstract class ImageViewEvent extends Equatable {
  const ImageViewEvent();
}

class ImageViewApiEvent extends ImageViewEvent {
  final String item;

  const ImageViewApiEvent(this.item);

  @override
  List<Object?> get props => [item];
}
