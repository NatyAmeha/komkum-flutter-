import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  String? image;
  double width;
  double height;
  String placeholder;
  BoxFit? fit;
  String? srcLocation;
  bool? roundImage;
  double borderRadius;
  bool cache;
  Function? onloading;
  Function? onCompleted;
  Function? onError;
  Widget? imageErrorWidget;
  CustomImage(
    this.image, {
    this.width = 100,
    this.height = 100,
    this.placeholder = "assets/images/placeholder.png",
    this.fit = BoxFit.cover,
    this.roundImage = false,
    this.borderRadius = 8,
    this.cache = true,
    this.srcLocation = "network",
    this.onloading,
    this.onCompleted,
    this.onError,
    this.imageErrorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // load image based from network or asset based on the src variable
    if (srcLocation == "network") {
      return roundImage == true
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: FadeInImage.assetNetwork(
                  image: image ?? placeholder,
                  placeholder: placeholder,
                  placeholderFit: BoxFit.cover,
                  width: width,
                  height: height,
                  fit: fit,
                  imageErrorBuilder: (context, exception, stack) {
                    onError?.call();
                    return imageErrorWidget ??
                        Image.asset(placeholder, width: width, height: height);
                  }),
            )
          : FadeInImage.assetNetwork(
              image: image ?? placeholder,
              placeholder: placeholder,
              width: width,
              height: height,
              imageErrorBuilder: (context, exception, stack) {
                onError?.call();
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageErrorWidget ??
                      Image.asset(
                        placeholder,
                        width: width,
                        height: height,
                        fit: fit,
                      ),
                );
              },
              fit: fit,
            );
    } else if (srcLocation == "NETWORK_WITH_LOADING") {
      return Image.network(image ?? placeholder, width: width, height: height,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          onCompleted?.call();
          return child;
        }
        onloading?.call();
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      }, errorBuilder: (context, exception, stack) {
        onError?.call();
        return imageErrorWidget ?? Image.asset(placeholder);
      });
    } else {
      return roundImage == true
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image ?? placeholder,
                  width: width,
                  height: height,
                  fit: fit, errorBuilder: (context, error, stackTrace) {
                onError?.call();
                return imageErrorWidget ?? Image.asset(placeholder);
              }))
          : Image.asset(image ?? placeholder,
              width: width,
              height: height,
              fit: fit, errorBuilder: (context, exception, stack) {
              onError?.call();
              return imageErrorWidget ?? Image.asset(placeholder);
            });
    }
  }
}
