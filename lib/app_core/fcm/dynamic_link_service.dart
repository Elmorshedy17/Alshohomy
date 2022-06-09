//
//
// class DynamicLinkService {
//   final NavigationService _navigationService = locator<NavigationService>();
//
//   Future handleDynamicLinks() async {
//     await Future.delayed(const Duration(seconds: 5));
//
//     // Register a link callback to fire if the app is opened up from the background
//     // using a dynamic link.
//     FirebaseDynamicLinks.instance.onLink
//         .listen((PendingDynamicLinkData dynamicLink) async {
//       // handle link that has been retrieved
//       _handleDeepLink(dynamicLink);
//     }).onError((error) async {
//       print('Link Failed: ${error.message}');
//     });
//
//     // Get the initial dynamic link if the app is opened with a dynamic link
//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     print('PendingDynamicLinkData: ${data?.link}');
//
//     // handle link that has been retrieved
//     _handleDeepLink(data);
//   }
//
//   void _handleDeepLink(PendingDynamicLinkData? data) {
//     final Uri? deepLink = data?.link;
//     if (deepLink != null) {
//       print('_handleDeepLink | deeplink: $deepLink');
//       var isStar = deepLink.pathSegments.contains('star');
//       if (isStar) {
//         // var id = deepLink.queryParameters['title'];
//         var starId = deepLink.pathSegments.last;
//         if (starId.isNotEmpty) {
//           // _navigationService.navigateTo(CreatePostViewRoute, arguments: title);
//           _navigationService.pushNamedTo(AppRoutesNames.StarDetailsPage,
//               arguments: StarDetailsArgs(
//                 starDetailsRequest: StarDetailsRequest(starId: starId),
//               ));
//         }
//       } else {
//         var productId = deepLink.pathSegments.last;
//         if (productId.isNotEmpty) {
//           _navigationService.pushNamedTo(
//             AppRoutesNames.ProductDetails,
//             arguments: ProductDetailsArgs(
//                 productId: int.parse(productId), navigateFrom: "home"),
//           );
//         }
//       }
//     }
//   }
//
//   Future<String> createProductLink(
//       {required int productId,
//       String? title,
//       String? description,
//       Uri? uri}) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://begoapp.page.link',
//       link: Uri.parse('https://linkalintest.com/bego/product/$productId'),
//       // 'https://linkalintest.com/bego/product/$productId?ofl=https://play.google.com/store'),
//
//       androidParameters: const AndroidParameters(
//         packageName: 'com.app.bego',
//         minimumVersion: 1,
//       ),
//
//       // Other things to add as an example. We don't need it now
//       iosParameters: const IOSParameters(
//         bundleId: 'com.app.bego',
//         minimumVersion: '1',
//         appStoreId: '123456789',
//       ),
//       // googleAnalyticsParameters: const GoogleAnalyticsParameters(
//       //   campaign: 'example-promo',
//       //   medium: 'social',
//       //   source: 'orkut',
//       // ),
//       // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
//       //   providerToken: '123456',
//       //   campaignToken: 'example-promo',
//       // ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: title,
//         imageUrl: uri,
//         description: description,
//       ),
//     );
//
//     // final Uri dynamicUrl = await parameters.buildUrl();
//     // final Uri longLink =
//     //     await FirebaseDynamicLinks.instance.buildLink(parameters);
//
//     final ShortDynamicLink shortDynamicLink =
//         await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//
//     final Uri dynamicUrl = shortDynamicLink.shortUrl;
//
//     return dynamicUrl.toString();
//   }
//
//   Future<String> createStarLink(
//       {required int starId,
//       String? title,
//       String? description,
//       Uri? uri}) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://begoapp.page.link',
//       link: Uri.parse('https://linkalintest.com/bego/star/$starId'),
//       // 'https://linkalintest.com/bego/star/$starId?ofl=https://play.google.com/store'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.app.bego',
//         minimumVersion: 1,
//       ),
//
//       // Other things to add as an example. We don't need it now
//       iosParameters: const IOSParameters(
//         bundleId: 'com.app.bego',
//         minimumVersion: '1',
//         appStoreId: '123456789',
//       ),
//       // googleAnalyticsParameters: const GoogleAnalyticsParameters(
//       //   campaign: 'example-promo',
//       //   medium: 'social',
//       //   source: 'orkut',
//       // ),
//       // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
//       //   providerToken: '123456',
//       //   campaignToken: 'example-promo',
//       // ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: title,
//         imageUrl: uri,
//         description: description,
//       ),
//     );
//
//     // final Uri dynamicUrl = await parameters.buildUrl();
//     final ShortDynamicLink shortDynamicLink =
//         await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//
//     final Uri dynamicUrl = shortDynamicLink.shortUrl;
//
//     return dynamicUrl.toString();
//   }
// }
