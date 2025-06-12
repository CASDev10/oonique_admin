import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../constants.dart';
import '../../../my_files.dart';

class DashboardInfoCard extends StatefulWidget {
  final VoidCallback onTap;
  const DashboardInfoCard({Key? key, required this.info, required this.onTap})
    : super(key: key);

  final DashBoardInfoCard info;

  @override
  State<DashboardInfoCard> createState() => _DashboardInfoCardState();
}

class _DashboardInfoCardState extends State<DashboardInfoCard> {
  bool _highlight = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter:
          (e) => setState(() {
            _highlight = true;
          }),
      onExit:
          (e) => setState(() {
            _highlight = false;
          }),
      child: Transform.scale(
        scale: _highlight ? 1.04 : 1,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(defaultPadding * 0.75),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: widget.info.color!.withOpacity(0.4),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: SvgPicture.asset(
                        widget.info.svgSrc!,
                        width: 32,
                        height: 32,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.info.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
