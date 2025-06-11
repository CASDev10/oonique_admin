import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/dashboard/view/banner/models/banner_delete_response.dart';
import 'package:oonique/modules/main/screens/banners/repositories/repo.dart';

import '../../../../../core/exceptions/api_error.dart';
import '../../../../../utils/logger/logger.dart';
import '../../../../dashboard/view/banner/models/get_banners_response.dart';

part 'banner_ads_state.dart';

class BannerAdsCubit extends Cubit<BannerAdsState> {
  final BannersRepository _bannersRepository;

  BannerAdsCubit({required BannersRepository bannersRepository})
    : _bannersRepository = bannersRepository,
      super(BannerAdsState.initial());

  final _log = logger(BannerAdsCubit);

  Future<void> getAllBanners({int? page = 1}) async {
    emit(state.copyWith(bannersState: BannerAdsStatus.loading));

    try {
      GetBannerResponse response = await _bannersRepository.allBanners(
        page: page,
      );
      if (response.result == 'success') {
        emit(
          state.copyWith(
            bannersState: BannerAdsStatus.success,
            allBanners: response.data,
            totalItems: response.totalItems,
          ),
        );
      } else {
        emit(
          state.copyWith(
            bannersState: BannerAdsStatus.error,
            errorMessage: response.result,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(
          bannersState: BannerAdsStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> deleteBanner(int? bannerId) async {
    emit(state.copyWith(bannersState: BannerAdsStatus.loading));

    try {
      BannerDeleteResponse response = await _bannersRepository.deleteBanner(
        bannerId!,
      );
      if (response.result == 'success') {
        emit(
          state.copyWith(
            bannersState: BannerAdsStatus.success,
            errorMessage: response.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            bannersState: BannerAdsStatus.error,
            errorMessage: response.result,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(
          bannersState: BannerAdsStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }
}
