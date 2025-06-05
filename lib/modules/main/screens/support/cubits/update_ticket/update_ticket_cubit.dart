import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/main/screens/support/repository/support_repository.dart';

import '../../../../../../core/exceptions/api_error.dart';
import '../../../../../../utils/logger/logger.dart';
import '../../models/update_support_response.dart';

part 'update_ticket_state.dart';

class UpdateTicketCubit extends Cubit<UpdateTicketState> {
  final SupportRepository _supportRepository;

  UpdateTicketCubit({required SupportRepository supportRepository})
    : _supportRepository = supportRepository,
      super(UpdateTicketState.initial());

  final _log = logger(UpdateTicketCubit);

  Future<void> updateTicket({
    required int supportId,
    required String status,
  }) async {
    emit(state.copyWith(bannersState: UpdateTicketStatus.loading));

    try {
      UpdateSupportResponse response = await _supportRepository.updateTicket(
        supportId: supportId,
        status: status,
      );
      if (response.result == 'success') {
        emit(
          state.copyWith(
            bannersState: UpdateTicketStatus.success,
            errorMessage: response.result,
          ),
        );
      } else {
        emit(
          state.copyWith(
            bannersState: UpdateTicketStatus.error,
            errorMessage: response.result,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(
          bannersState: UpdateTicketStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
