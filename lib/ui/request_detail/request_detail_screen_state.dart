part of 'request_detail_screen_cubit.dart';

@immutable
abstract class RequestDetailScreenState {}

class RequestDetailScreenInitial extends RequestDetailScreenState {}
class Accepting extends RequestDetailScreenState {}
class Loading extends RequestDetailScreenState {}
class Error extends RequestDetailScreenState {
  final String msg;

  Error(this.msg);
}
class ReceivedDetail extends RequestDetailScreenState {
  final RequestModel requestModel;

  ReceivedDetail(this.requestModel);
}
class AcceptedSuccessfully extends RequestDetailScreenState {}

