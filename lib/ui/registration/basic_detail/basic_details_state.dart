part of 'basic_details_cubit.dart';

@immutable
abstract class BasicDetailsState {}

class BasicDetailsInitial extends BasicDetailsState {}
class Loading extends BasicDetailsState {}
class Error extends BasicDetailsState {
  final String msg;

  Error(this.msg);

}
class AddedSuccessfully extends BasicDetailsState {}
class Failed extends BasicDetailsState {}
