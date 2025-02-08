import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imagen;
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;

  const CachedNetworkImageWidget({
    super.key,
    required this.imagen,
    this.height = 350,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imagen,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (context, url) => ClipRRect(
          borderRadius: borderRadius,
          child: Image(
            image: const AssetImage('assets/gif/loading.gif'),
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
        errorWidget: (context, url, error) => ClipRRect(
          borderRadius: borderRadius,
          child: Image(
            image: const AssetImage('assets/images/noimage.png'),
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}