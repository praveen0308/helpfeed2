part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class Updating extends EditProfileState {}
class Error extends EditProfileState {
  final String msg;

  Error(this.msg);
}
class UpdatedSuccessfully extends EditProfileState {}
