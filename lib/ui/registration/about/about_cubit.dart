import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInitial());
}
