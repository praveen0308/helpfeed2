part of 'receiver_dashboard_data_cubit.dart';

@immutable
abstract class ReceiverDashboardDataState {}

class ReceiverDashboardDataInitial extends ReceiverDashboardDataState {}
class LoadingRequests extends ReceiverDashboardDataState {}
class Error extends ReceiverDashboardDataState {
  final String msg;

  Error(this.msg);
}
class NoRequests extends ReceiverDashboardDataState {}
class ReceivedRequests extends ReceiverDashboardDataState {
  final List<RequestModel> requests;

  ReceivedRequests(this.requests);
}
