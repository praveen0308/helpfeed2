import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'address_details_state.dart';

class AddressDetailsCubit extends Cubit<AddressDetailsState> {
  AddressDetailsCubit() : super(AddressDetailsInitial());
}
