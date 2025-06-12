import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/heights_and_widths.dart';
import 'package:oonique/utils/utils.dart';
import '../../../../../config/routes/nav_router.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../ui/widgets/loading_indicator.dart';
import '../../../../../utils/display/display_utils.dart';
import '../cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import '../cubit/banner_ads_cubit.dart';
import '../../../repo/repo.dart';
import '../widgets/paginated_banner_table.dart';
import '../widgets/update_banner_dialogue.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BannerAdsCubit(bannersRepository: sl<BannersRepository>())
                ..getAllBanners(),
        ),
        BlocProvider(
          create: (context) => AddUpdateBannerCubit(
            bannersRepository: sl<BannersRepository>(),
          )..getCategories(),
        ),
      ],
      child: BannerScreenView(),
    );
  }
}

class BannerScreenView extends StatefulWidget {
  const BannerScreenView({
    super.key,
  });

  @override
  State<BannerScreenView> createState() => _BannerScreenViewState();
}

class _BannerScreenViewState extends State<BannerScreenView> {
  void showAddNewUserDialog(
    BuildContext context,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => UpdateBannerDialogue(
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
  }

  String selectedOption = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerAdsCubit, BannerAdsState>(
      builder: (context, state) {
        if (state.bannersState == BannerAdsStatus.loading) {
          return LoadingIndicator();
        }
        return Container(
            padding: const EdgeInsets.all(14),
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: BlocConsumer<AddUpdateBannerCubit, AddUpdateBannerState>(
              listener: (BuildContext context, AddUpdateBannerState state) {
                if (state.bannersState == AddUpdateBannerStatus.loading) {
                  DisplayUtils.showLoader();
                } else if (state.bannersState ==
                    AddUpdateBannerStatus.success) {
                  DisplayUtils.removeLoader();
                } else if (state.bannersState == AddUpdateBannerStatus.error) {
                  DisplayUtils.removeLoader();
                } else {
                  DisplayUtils.removeLoader();
                }
              },
              builder: (context, addBannerState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Users',
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            h0P5,
                            Text(
                              'Manage user accounts, roles, and permissions.',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.titlaTextColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        PrimaryButton(
                          onPressed: () {
                            showAddNewUserDialog(context);
                          },
                          title: 'Add Banner',
                          width: 120,
                          height: 40,
                          fontSize: 13,
                          backgroundColor: AppColors.primaryColor,
                          bborderColor: AppColors.transparent,
                        ),
                      ],
                    ),
                    h2,

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
                        banners: state.allBanners,
                      ),
                    ),
                    // UsersDataTable(),
                  ],
                );
              },
            ));
      },
    );
  }
}
