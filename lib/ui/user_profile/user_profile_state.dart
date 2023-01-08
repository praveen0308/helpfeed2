part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}
class LoadingProfile extends UserProfileState {}
class Error extends UserProfileState {
  final String msg;

  Error(this.msg);

}
class ReceivedUserDetails extends UserProfileState {
  final UserModel user;

  ReceivedUserDetails(this.user);

}
