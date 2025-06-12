part of 'support_cubits.dart';

enum SupportsTicketStatus { initial, loading, success, error }

class SupportsTicketState extends Equatable {
  final SupportsTicketStatus bannersState;
  final List<SupportResponseModel> tickets;
  final String errorMessage;
  final int totalItems;

  const SupportsTicketState({
    required this.bannersState,
    required this.errorMessage,
    required this.tickets,
    required this.totalItems,
  });

  factory SupportsTicketState.initial() {
    return SupportsTicketState(
      bannersState: SupportsTicketStatus.initial,
      errorMessage: '',
      totalItems: 0,
      tickets: [],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [bannersState, tickets, errorMessage];

  SupportsTicketState copyWith({
    SupportsTicketStatus? bannersState,
    String? errorMessage,
    List<SupportResponseModel>? tickets,
    int? totalItems,
  }) {
    return SupportsTicketState(
      bannersState: bannersState ?? this.bannersState,
      totalItems: totalItems ?? this.totalItems,
      errorMessage: errorMessage ?? this.errorMessage,
      tickets: tickets ?? this.tickets,
    );
  }
}
