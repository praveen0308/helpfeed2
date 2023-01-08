part of 'donor_dashboard_data_cubit.dart';

@immutable
abstract class DonorDashboardDataState {}

class DonorDashboardDataInitial extends DonorDashboardDataState {}

class Loading extends DonorDashboardDataState {}
class NoData extends DonorDashboardDataState {}

class Error extends DonorDashboardDataState {
  final String msg;
  Error(this.msg);
}

class ReceivedData extends DonorDashboardDataState {
  final List<UserModel> data;

  ReceivedData(this.data);
}
