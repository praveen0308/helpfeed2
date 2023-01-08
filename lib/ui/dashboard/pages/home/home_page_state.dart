part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}
class LoadingRequests extends HomePageState {}
class Error extends HomePageState {
  final String msg;

  Error(this.msg);
}
class NoRequests extends HomePageState {}
class ReceivedRequests extends HomePageState {
  final List<RequestModel> requests;

  ReceivedRequests(this.requests);
}
