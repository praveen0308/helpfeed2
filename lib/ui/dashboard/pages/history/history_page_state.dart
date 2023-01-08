part of 'history_page_cubit.dart';

@immutable
abstract class HistoryPageState {}

class HistoryPageInitial extends HistoryPageState {}
class Loading extends HistoryPageState {}
class NoHistory extends HistoryPageState {}
class Error extends HistoryPageState {
  final String msg;
  Error(this.msg);
}
class ReceivedRequests extends HistoryPageState {
  final List<RequestModel> requests;

  ReceivedRequests(this.requests);
}
