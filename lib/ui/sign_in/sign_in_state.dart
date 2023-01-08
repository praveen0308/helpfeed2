part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}
class SigningIn extends SignInState {}
class Validating extends SignInState {}
class ValidationFailed extends SignInState {}
class AlreadyUser extends SignInState {}
class NewUserRegistered extends SignInState {

}
class SignInSuccessful extends SignInState {
  final User user;

  SignInSuccessful(this.user);

}
class SignInFailed extends SignInState {}
