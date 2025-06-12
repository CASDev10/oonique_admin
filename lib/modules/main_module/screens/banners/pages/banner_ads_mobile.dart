import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/utils/display/display_utils.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../config/routes/nav_router.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../ui/widgets/loading_indicator.dart';
import '../../../../../ui/widgets/primary_button.dart';
import '../../../../dashboard/view/banner/widgets/paginated_banner_table.dart';
import '../cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import '../cubit/banner_ads_cubit.dart';
import '../../../../dashboard/repo/repo.dart';
import '../../../../dashboard/view/banner/widgets/update_banner_dialogue.dart';
import 'banner_ads_desktop.dart';

class BannerAdsMobile extends StatelessWidget {
  const BannerAdsMobile({super.key});

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
      child: BannerAdsMobileView(),
    );
  }
}

class BannerAdsMobileView extends StatefulWidget {
  const BannerAdsMobileView({super.key});

  @override
  State<BannerAdsMobileView> createState() => _BannerAdsMobileViewState();
}

class _BannerAdsMobileViewState extends State<BannerAdsMobileView> {
  @override
  void initState() {
    setState(() {
      context.read<BannerAdsCubit>().getAllBanners();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: BlocBuilder<BannerAdsCubit, BannerAdsState>(
        builder: (context, state) {
          if (state.bannersState == BannerAdsStatus.loading) {
            return LoadingIndicator();
          }
          return BlocConsumer<AddUpdateBannerCubit, AddUpdateBannerState>(
            builder: (context, addBannerState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          onPressed: () async {
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
                  SizedBox(height: 12.0),
                  Expanded(
                    child: PaginatedBannersTable(
                      totalItems: state.totalItems,
                      key: ValueKey(state.allBanners.length),
                      banners: state.allBanners,
                  
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
