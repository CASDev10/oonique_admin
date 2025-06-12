import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/dashboard/view/banner/models/filters_response.dart';
import 'package:oonique/modules/dashboard/repo/repo.dart';

import '../../../../../../core/exceptions/api_error.dart';
import '../../../../../../utils/logger/logger.dart';
import '../../../../../dashboard/view/banner/models/add_banner_input.dart';
import '../../../../../dashboard/view/banner/models/add_banner_response.dart';

part 'add_update_banner_state.dart';

class AddUpdateBannerCubit extends Cubit<AddUpdateBannerState> {
  final BannersRepository _bannersRepository;

  AddUpdateBannerCubit({required BannersRepository bannersRepository})
    : _bannersRepository = bannersRepository,
      super(AddUpdateBannerState.initial());

  final _log = logger(AddUpdateBannerCubit);

  Future<void> getCategories() async {
    emit(state.copyWith(bannersState: AddUpdateBannerStatus.loading));

    try {
      FiltersResponse response = await _bannersRepository.getCategories();

      if (response.result == 'success') {
        emit(
          state.copyWith(
            bannersState: AddUpdateBannerStatus.success,
            categories: response.data.filters.firstWhere(
              (v) => v.key == "kategorie",
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            bannersState: AddUpdateBannerStatus.error,
            errorMessage: response.result,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(
          bannersState: AddUpdateBannerStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> addUpdateBanners(AddBannerInput input) async {
    emit(state.copyWith(bannersState: AddUpdateBannerStatus.loading));

    try {
      AddBannerResponse response = await _bannersRepository.addUpdateBanner(
        input,
      );
      if (response.result == 'success') {
        emit(
          state.copyWith(
            bannersState: AddUpdateBannerStatus.success,
            errorMessage: response.result,
          ),
        );
      } else {
        emit(
          state.copyWith(
            bannersState: AddUpdateBannerStatus.error,
            errorMessage: response.result,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(
          bannersState: AddUpdateBannerStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
