import 'package:flutter/widgets.dart';

class CustomFadeInImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String placeHolderAssetImagePath;
  final ImageProvider<Object> image;

  const CustomFadeInImageWidget(
      {super.key,
      this.width = 163,
      this.height = 79,
      this.fit,
      this.placeHolderAssetImagePath =
          "assets/images/supermarket_placeholder.png",
      required this.image});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      width: width,
      height: height,
      fit: fit,
      placeholder: AssetImage(
        placeHolderAssetImagePath,
      ),
      image: image,
      imageErrorBuilder: (context, error, stackTrace) => SizedBox(
        width: width,
        height: height,
        child: Image.asset(placeHolderAssetImagePath),
      ),
    );
  }
}
