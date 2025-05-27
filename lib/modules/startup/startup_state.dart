part of 'startup_cubit.dart';

enum Status { none, unauthenticated, authenticated }

class StartupState extends Equatable {
  final Status status;

  const StartupState({required this.status});

  factory StartupState.initial() {
    return StartupState(status: Status.none);
  }

  StartupState copyWith({Status? status}) {
    return StartupState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
