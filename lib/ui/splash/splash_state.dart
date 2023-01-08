part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class CheckingAuthentication extends SplashState {}
class Authenticated extends SplashState {}
class UnAuthenticated extends SplashState {}
