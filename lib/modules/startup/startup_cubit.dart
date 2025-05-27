import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../utils/logger/logger.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  final _log = logger(StartupCubit);
  StartupCubit({required DioClient dioClient})
    : _dioClient = dioClient,
      super(StartupState.initial());

  final DioClient _dioClient;

  void init() async {
    await Future.delayed(const Duration(seconds: 3));
    if (false) {
      emit(state.copyWith(status: Status.authenticated));
    } else {
      emit(state.copyWith(status: Status.unauthenticated));
    }
  }
}
