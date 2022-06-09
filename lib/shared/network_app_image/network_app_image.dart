// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shimmer/shimmer.dart';
// // import 'package:shimmer/shimmer.dart';
//
// class NetworkAppImage extends StatelessWidget {
//   final String imageUrl;
//   final double? height, width;
//   final BoxFit? boxFit;
//   final Widget? placeholderWidget, errorWidget;
//   final Color? imageColor;
//   const NetworkAppImage(
//       {Key? key,
//       required this.imageUrl,
//       this.height,
//       this.width,
//       this.boxFit,
//       this.placeholderWidget,
//       this.errorWidget,
//       this.imageColor})
//       : super(key: key);
//
//   /// _defaultPlaceholderWidget
//   Widget _defaultPlaceholderWidget() => Shimmer.fromColors(
//         baseColor: Colors.grey[200]!,
//         highlightColor: Colors.white,
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.white,
//         ),
//       );
//
//   /// _defaultErrorWidget
//   Widget _defaultErrorWidget() => SvgPicture.asset(
//         "assets/images/imgPlaceholder.svg",
//         color: Colors.grey[100],
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       color: imageColor,
//       fit: boxFit,
//       height: height,
//       width: width,
//       imageUrl: '$imageUrl',
//       placeholder: (context, url) =>
//           placeholderWidget ?? _defaultPlaceholderWidget(),
//       errorWidget: (context, url, error) =>
//           errorWidget ?? _defaultErrorWidget(),
//     );
//   }
// }
