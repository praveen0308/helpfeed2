part of 'upload_images_cubit.dart';

@immutable
abstract class UploadImagesState {}

class UploadImagesInitial extends UploadImagesState {}
class UploadingImages extends UploadImagesState {}
class Error extends UploadImagesState {
  final String msg;

  Error(this.msg);
}
class ImageUploaded extends UploadImagesState {
  final List<String> downloadUrls;

  ImageUploaded(this.downloadUrls);
}

