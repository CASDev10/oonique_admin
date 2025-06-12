import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/dashboard/view/support/repository/support_repository.dart';

import '../../../../../core/exceptions/api_error.dart';
import '../../../../../utils/logger/logger.dart';
import '../models/all_support_response.dart';

part 'support_state.dart';

class SupportsTicketCubit extends Cubit<SupportsTicketState> {
  final SupportRepository _supportRepository;

  SupportsTicketCubit({required SupportRepository supportRepository})
    : _supportRepository = supportRepository,
      super(SupportsTicketState.initial());

  final _log = logger(SupportsTicketCubit);

  Future<void> getAllTickets({int? page = 1}) async {
    emit(state.copyWith(bannersState: SupportsTicketStatus.loading));

    try {
      AllSupportResponse response = await _supportRepository.allTickets();
      if (response.result == 'success') {
        emit(
          state.copyWith(
            bannersState: SupportsTicketStatus.success,
            tickets: response.data,
            totalItems: response.totalItems,
          ),
        );
      } else {
        emit(
          state.copyWith(
            bannersState: SupportsTicketStatus.error,
            errorMessage: response.result,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(
          bannersState: SupportsTicketStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
