import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(ProfilePageInitial());
}
