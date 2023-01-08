part of 'donate_screen_cubit.dart';

@immutable
abstract class DonateScreenState {}

class DonateScreenInitial extends DonateScreenState {}

class Loading extends DonateScreenState {}

class SuccessfullyDonated extends DonateScreenState {}

class Error extends DonateScreenState {
  final String msg;

  Error(this.msg);
}
