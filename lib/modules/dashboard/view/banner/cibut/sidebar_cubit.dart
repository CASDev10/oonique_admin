import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sidebar_state.dart';

class SideBarCubit extends Cubit<SideBarState> {
  SideBarCubit() : super(const SideBarState(index: 0));

  void setSideBarItem(int index) {
    emit(SideBarState(index: index));
  }
}
