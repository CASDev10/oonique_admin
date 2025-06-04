part of 'update_ticket_cubit.dart';

enum UpdateTicketStatus { initial, loading, success, error }

class UpdateTicketState extends Equatable {
  final UpdateTicketStatus bannersState;

  final String errorMessage;

  const UpdateTicketState({
    required this.bannersState,
    required this.errorMessage,
  });

  factory UpdateTicketState.initial() {
    return UpdateTicketState(
      bannersState: UpdateTicketStatus.initial,
      errorMessage: '',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [bannersState, errorMessage];

  UpdateTicketState copyWith({
    UpdateTicketStatus? bannersState,
    String? errorMessage,
  }) {
    return UpdateTicketState(
      bannersState: bannersState ?? this.bannersState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
