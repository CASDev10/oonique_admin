// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:oonique/utils/extensions/extended_context.dart';
//
// import 'circular_cached_image.dart';
//
// class PictureWidget extends StatelessWidget {
//   final String imageUrl;
//   final VoidCallback? onTap;
//   final double width;
//   final double height;
//   final bool isEditable;
//   final double radius;
//   final String errorPath;
//
//   const PictureWidget({
//     Key? key,
//     required this.imageUrl,
//     this.onTap,
//     this.width = 140,
//     this.height = 140,
//     this.isEditable = false,
//     this.radius = 70,
//     required this.errorPath,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     print(imageUrl);
//     return Center(
//       child: Stack(
//         children: [
//           imageUrl.contains('http')
//               ? Hero(
//                 tag: imageUrl,
//                 child: CircularCachedImage(
//                   imageUrl: imageUrl,
//                   width: width,
//                   height: height,
//                   borderRadius: radius,
//                   errorPath: errorPath,
//                 ),
//               )
//               : Container(
//                 width: width,
//                 height: height,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.withOpacity(.5)),
//                   borderRadius: BorderRadius.circular(radius),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image:
//                         imageUrl.contains('assets/')
//                             ? AssetImage(imageUrl) as ImageProvider
//                             : FileImage(File(imageUrl)),
//                   ),
//                 ),
//               ),
//           Positioned(
//             bottom: -5,
//             right: 0,
//             child: Visibility(
//               visible: isEditable,
//               child: IconButton(
//                 onPressed: onTap,
//                 icon: Container(
//                   height: 40,
//                   width: 40,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: context.colorScheme.background,
//                     boxShadow: [
//                       BoxShadow(
//                         color: context.colorScheme.primary.withOpacity(0.8),
//                         blurRadius: 2,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   child: Icon(Icons.edit),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oonique/constants/app_colors.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import 'circular_cached_image.dart';

class PictureWidget extends StatelessWidget {
  final String imageUrl;
  final Uint8List? imageBytes;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final bool isEditable;
  final double radius;
  final String errorPath;

  const PictureWidget({
    Key? key,
    required this.imageUrl,
    this.imageBytes,
    this.onTap,
    this.width = 140,
    this.height = 140,
    this.isEditable = false,
    this.radius = 70,
    required this.errorPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    Widget imageWidget;

    if (imageBytes != null) {
      imageWidget = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.dialogBgColor,
          border: Border.all(color:AppColors.borderColor),
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: MemoryImage(imageBytes!),
          ),
        ),
      );
    } else if (imageUrl.contains('http')) {
      imageWidget = Hero(
        tag: imageUrl,
        child: CircularCachedImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          borderRadius: radius,
          errorPath: errorPath,
        ),
      );
    } else {
      imageWidget = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.dialogBgColor,
          border: Border.all(color: Colors.grey.withOpacity(.5)),
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image:
                imageUrl.contains('assets/')
                    ? AssetImage(imageUrl) as ImageProvider
                    : FileImage(File(imageUrl)),
          ),
        ),
      );
    }

    return Center(
      child: Stack(
        children: [
          imageWidget,
          Positioned(
            bottom: -5,
            right: 0,
            child: Visibility(
              visible: isEditable,
              child: IconButton(
                onPressed: onTap,
                icon: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.primary.withOpacity(0.8),
                        blurRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Icon(Icons.edit),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
