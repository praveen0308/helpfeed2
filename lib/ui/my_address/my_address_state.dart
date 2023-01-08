part of 'my_address_cubit.dart';

@immutable
abstract class MyAddressState {}

class MyAddressInitial extends MyAddressState {}
class Loading extends MyAddressState {}
class StoredSuccessfully extends MyAddressState {}
class Error extends MyAddressState {
  final String msg;

  Error(this.msg);

}
