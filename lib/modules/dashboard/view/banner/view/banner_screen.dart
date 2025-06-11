import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oonique/ui/input/custom_input_field.dart';
import 'package:oonique/ui/input/input_field.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/heights_and_widths.dart';
import 'package:oonique/utils/utils.dart';

import '../../../../../config/routes/nav_router.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../ui/widgets/loading_indicator.dart';
import '../../../../main/screens/banners/cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import '../../../../main/screens/banners/cubit/banner_ads_cubit.dart';
import '../../../../main/screens/banners/repositories/repo.dart';
import '../../../widgets/paginated_banner_table.dart';
import '../widgets/update_banner_dialogue.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BannerAdsCubit(bannersRepository: sl<BannersRepository>()),
        ),
        BlocProvider(
          create: (context) => AddUpdateBannerCubit(
            bannersRepository: sl<BannersRepository>(),
          ),
        ),
      ],
      child: BannerScreenView(size: size),
    );
  }
}

class BannerScreenView extends StatefulWidget {
  final Size? size;

  const BannerScreenView({super.key, this.size});

  @override
  State<BannerScreenView> createState() => _BannerScreenViewState();
}

class _BannerScreenViewState extends State<BannerScreenView> {
  List<Map<String, dynamic>> options = [
    {
      'label': 'All',
      'icon': 'assets/images/svg/allUsers.svg',
      'count': 8,
    },
    // {
    //   'label': 'Administrators',
    //   'icon': 'assets/images/svg/admin.svg',
    //   'count': 1,
    // },
    // {
    //   'label': '2FA Active',
    //   'icon': 'assets/images/svg/icon4.svg',
    //   'count': 3,
    // },
    {
      'label': 'Banned',
      'icon': 'assets/images/svg/icon3.svg',
      'count': 1,
    },
  ];

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
    return SingleChildScrollView(
      child: BlocBuilder<BannerAdsCubit, BannerAdsState>(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SizedBox(
                        width: 230,
                        child: CustomInputField(
                          controller: TextEditingController(),
                          label: 'Search users...',
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(left: 12.0, right: 8),
                            child: SvgPicture.asset(
                              'assets/images/svg/searchIcon.svg',
                              color: AppColors.titlaTextColor,
                              width: 16,
                              height: 16,
                            ),
                          ),
                          borderRadius: 6,
                          borderColor: AppColors.borderColor,
                          fillColor: AppColors.dialogBgColor,
                          focusBorderColor: AppColors.borderColor,
                          textColor: AppColors.white,
                          hintColor: AppColors.titlaTextColor,
                          horizontalPadding: 0,
                          boxConstraints: 40,
                        ),
                      ),
                      w1,
                      PrimaryButton(
                        onPressed: () {
                          showAddNewUserDialog(context);
                        },
                        title: 'Add User',
                        width: 120,
                        height: 40,
                        fontSize: 13,
                        backgroundColor: AppColors.primaryColor,
                        borderColor: AppColors.transparent,
                      ),
                    ],
                  ),
                  h2,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: options.map((option) {
                        final isSelected = selectedOption == option['label'];
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedOption = option['label'];
                                });
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(
                                          0xFF121317) // Selected background
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        option['icon'],
                                        color: isSelected
                                            ? AppColors.white
                                            : AppColors.titlaTextColor,
                                        width: 16,
                                        height: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        option['label'],
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppColors.white
                                              : AppColors.titlaTextColor,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFF383A45)
                                              : const Color(0xFF2D2F3A),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          option['count'].toString(),
                                          style: TextStyle(
                                            color: isSelected
                                                ? AppColors.white
                                                : AppColors.titlaTextColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  h1,
                  Expanded(
                    child: PaginatedBannersTable(
                      onDelete: (v) async {
                        await context
                            .read<BannerAdsCubit>()
                            .deleteBanner(v)
                            .then((v) async {
                          await context.read<BannerAdsCubit>().getAllBanners();
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
                      size: widget.size ?? MediaQuery.of(context).size,
                      banners: state.allBanners,
                    ),
                  ),
                  // UsersDataTable(),
                ],
              ));
        },
      ),
    );
  }
}
