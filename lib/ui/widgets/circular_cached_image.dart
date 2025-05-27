import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class CircularCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final String errorPath;
  final double borderRadius;

  const CircularCachedImage({super.key, 
    required this.imageUrl,
    this.width = 280,
    this.height = 280,
    this.fit = BoxFit.cover,
    required this.errorPath , this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const Center(child: LoadingIndicator(),),
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover,),
            border: Border.all(color: Colors.grey.withOpacity(.3)),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        errorWidget: (context, url, error) =>  ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(.5)),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Image.asset(errorPath, fit: BoxFit.cover,),
          ),
        ),
        fit: fit,
      ),
    );
  }
}
