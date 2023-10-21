import 'package:equatable/equatable.dart';

class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object?> get props => [];
}
class GalleryInitialState extends GalleryState{
  const GalleryInitialState();
}

class GalleryLoadingState extends GalleryState{
  const GalleryLoadingState();
}

class GallerySuccessfulState extends GalleryState{
  final Map<String, dynamic> galleryList;
  const GallerySuccessfulState(this.galleryList);
  @override
  List<Object> get props => [galleryList];
}

class GalleryErrorState extends GalleryState{
  final String message;
  const GalleryErrorState(this.message);
  @override
  List<Object> get props => [message];
}
