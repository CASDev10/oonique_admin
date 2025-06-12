part of 'banner_ads_cubit.dart';

enum BannerAdsStatus { initial, loading, success, error }

class BannerAdsState extends Equatable {
  final BannerAdsStatus bannersState;
  final List<BannersModel> allBanners;
  final String errorMessage;
  final int totalItems;

  const BannerAdsState({
    required this.bannersState,
    required this.errorMessage,
    required this.allBanners,
    required this.totalItems,
  });

  factory BannerAdsState.initial() {
    return BannerAdsState(
      bannersState: BannerAdsStatus.initial,
      errorMessage: '',
      totalItems: 0,
      allBanners: [],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [bannersState, allBanners, errorMessage];

  BannerAdsState copyWith({
    BannerAdsStatus? bannersState,
    String? errorMessage,
    List<BannersModel>? allBanners,
    int? totalItems,
  }) {
    return BannerAdsState(
      bannersState: bannersState ?? this.bannersState,
      totalItems: totalItems ?? this.totalItems,
      errorMessage: errorMessage ?? this.errorMessage,
      allBanners: allBanners ?? this.allBanners,
    );
  }
}
