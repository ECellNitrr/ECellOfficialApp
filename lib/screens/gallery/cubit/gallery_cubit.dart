import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/screens/gallery/cubit/gallery_state.dart';
import 'package:ecellapp/screens/gallery/gallery_repository.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GalleryRepository _galleryRepository;
  GalleryCubit(this._galleryRepository) : super(GalleryInitialState());
  Future<void> getAllGalleryImages() async {
    try {
      emit(GalleryLoadingState());
      Map<String, dynamic> json = await _galleryRepository.getAllGalleryImages();
      emit(GallerySuccessfulState(json));
    } on NetworkException {
      emit(GalleryErrorState(S.networkException));
    } on ValidationException catch (e) {
      emit(GalleryErrorState(e.description));
    } on UnknownException {
      emit(GalleryErrorState(S.unknownException));
    } catch (e) {
      Log.s(tag: "GalleryCubit", message: "Weird Error. message ->" + e.toString());
    }
  }
}
