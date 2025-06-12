import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/main_module/screens/banners/cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import 'package:oonique/modules/main_module/screens/banners/cubit/banner_ads_cubit.dart';
import 'package:oonique/modules/dashboard/view/banner/models/get_banners_response.dart';
import 'package:oonique/modules/main_module/screens/banners/repositories/repo.dart';
import 'package:oonique/modules/dashboard/view/banner/widgets/update_banner_dialogue.dart';
import 'package:oonique/ui/widgets/helper_function.dart';
import 'package:oonique/ui/widgets/loading_indicator.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/extensions/extended_context.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../../config/routes/nav_router.dart';
import '../../../../../constants/api_endpoints.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../utils/display/display_utils.dart';
import '../../../../dashboard/widgets/paginated_banner_table.dart';

class BannerAdsDesktop extends StatelessWidget {
  const BannerAdsDesktop({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  BannerAdsCubit(bannersRepository: sl<BannersRepository>()),
        ),
        BlocProvider(
          create:
              (context) => AddUpdateBannerCubit(
                bannersRepository: sl<BannersRepository>(),
              ),
        ),
      ],
      child: BannerAdsDesktopView(size: size),
    );
  }
}

class BannerAdsDesktopView extends StatefulWidget {
  const BannerAdsDesktopView({super.key, required this.size});

  final Size size;
  @override
  State<BannerAdsDesktopView> createState() => _BannerAdsDesktopViewState();
}

class _BannerAdsDesktopViewState extends State<BannerAdsDesktopView> {
  @override
  void initState() {
    setState(() {
      context.read<BannerAdsCubit>().getAllBanners();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<BannerAdsCubit, BannerAdsState>(
        builder: (context, state) {
          if (state.bannersState == BannerAdsStatus.loading) {
            return LoadingIndicator();
          }
          return BlocConsumer<AddUpdateBannerCubit, AddUpdateBannerState>(
            builder: (context, addBannerState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Banners Ads Management",
                        style: context.textTheme.headlineLarge,
                      ),
                      SizedBox(
                        width: 120.0,
                        child: PrimaryButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder:
                                  (context) => UpdateBannerDialogue(
                                    onSave: (input) {
                                      context
                                          .read<AddUpdateBannerCubit>()
                                          .addUpdateBanners(input)
                                          .then((v) {
                                            NavRouter.pop(context);
                                          });
                                    },
                                  ),
                            ).then((v) {
                              context.read<BannerAdsCubit>().getAllBanners();
                            });
                          },
                          hMargin: 0,
                          height: 45.0,
                          title: "Add Banner",
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: PaginatedBannersTable(
                      onDelete: (v) async {
                        await context
                            .read<BannerAdsCubit>()
                            .deleteBanner(v)
                            .then((v) async {
                              await context
                                  .read<BannerAdsCubit>()
                                  .getAllBanners();
                            });
                      },
                      totalItems: state.totalItems,
                      onNext: (v) async {
                        await context.read<BannerAdsCubit>().getAllBanners(
                          page: v,
                        );
                      },
                      onPrevious: (v) async {
                        await context.read<BannerAdsCubit>().getAllBanners(
                          page: v,
                        );
                      },
                      key: ValueKey(state.allBanners.length),
                      banners: state.allBanners,
                      size: widget.size,
                    ),
                  ),
                ],
              );
            },
            listener: (BuildContext context, AddUpdateBannerState state) {
              if (state.bannersState == AddUpdateBannerStatus.loading) {
                DisplayUtils.showLoader();
              } else if (state.bannersState == AddUpdateBannerStatus.success) {
                DisplayUtils.removeLoader();
              } else if (state.bannersState == AddUpdateBannerStatus.error) {
                DisplayUtils.removeLoader();
              } else {
                DisplayUtils.removeLoader();
              }
            },
          );
        },
      ),
    );
  }
}

