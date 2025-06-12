part of 'add_update_banner_cubit.dart';

enum AddUpdateBannerStatus { initial, loading, success, error }

class AddUpdateBannerState extends Equatable {
  final AddUpdateBannerStatus bannersState;
  final Filter? categories;
  final String errorMessage;

  const AddUpdateBannerState({
    required this.bannersState,
    required this.categories,
    required this.errorMessage,
  });

  factory AddUpdateBannerState.initial() {
    return AddUpdateBannerState(
      bannersState: AddUpdateBannerStatus.initial,
      errorMessage: '',
      categories: null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [bannersState, errorMessage];

  AddUpdateBannerState copyWith({
    AddUpdateBannerStatus? bannersState,
    String? errorMessage,
    Filter? categories,
  }) {
    return AddUpdateBannerState(
      bannersState: bannersState ?? this.bannersState,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }
}
