part of 'images_screen_cubit.dart';

@immutable
abstract class ImagesScreenState {}

class ImagesScreenInitial extends ImagesScreenState {}
class Loading extends ImagesScreenState {}
class Error extends ImagesScreenState {
  final String msg;
  Error(this.msg);
}
class ReceivedImages extends ImagesScreenState {
  final List<String> images;

  ReceivedImages(this.images);

}
