import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../constants.dart';
import '../../../../../constants/asset_paths.dart';
import '../../../../../responsive.dart';
import '../../../../../ui/widgets/circular_cached_image.dart';
import '../../../../dashboard/view/banner/cibut/main_cubit.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MainCubit>().controlMenu,
          ),

        Text(title, style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  const ProfileCard({Key? key, required this.name, required this.imageUrl})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("User image url is $imageUrl");
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircularCachedImage(
            width: 30,
            height: 30,
            imageUrl: "",
            errorPath: AssetPaths.imageNotFoundPlaceHolder,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2,
              ),
              child: Text(name),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
