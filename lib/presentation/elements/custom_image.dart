import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomImage extends StatelessWidget {
  final String image;

  const CustomImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      errorWidget: (context, url, error) =>
          const FaIcon(FontAwesomeIcons.triangleExclamation),
    );
  }
}
