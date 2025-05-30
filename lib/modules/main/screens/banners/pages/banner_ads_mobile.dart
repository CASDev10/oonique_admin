import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../ui/widgets/primary_button.dart';
import '../cubit/banner_ads_cubit.dart';
import '../repositories/repo.dart';
import '../widgets/update_banner_dialogue.dart';
import 'banner_ads_desktop.dart';

class BannerAdsMobile extends StatelessWidget {
  const BannerAdsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              BannerAdsCubit(bannersRepository: sl<BannersRepository>())
                ..getAllBanners(),
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: BlocBuilder<BannerAdsCubit, BannerAdsState>(
        builder: (context, state) {
          // if (state.bannersState == BannerAdsStatus.success) {
          //   return LoadingIndicator();
          // }
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
                          builder: (context) => UpdateBannerDialogue(),
                        );
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
                  size: size,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
