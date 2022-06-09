import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/fcm/localNotificationService.dart';
import 'package:shahowmy_app/app_core/fcm/pushNotification_service.dart';
import 'package:shahowmy_app/app_core/resources/app_routes/routes.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';
import 'package:shahowmy_app/features/choose_language/choose_language_page.dart';
import 'package:shahowmy_app/features/home/home_page.dart';
import 'package:shahowmy_app/features/login/login_page.dart';

/// TODO: Uncomment when used Firebase
/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  //! Firebase Core.
  /// TODO: Uncomment when used Firebase
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Get any initial links
  // final PendingDynamicLinkData? initialLink =
  //     await FirebaseDynamicLinks.instance.getInitialLink();
  //
  // await Future.delayed(const Duration(seconds: 5));

  /*Set `enableInDevMode` to true to see reports while in debug mode
  This is only to be used for confirming that reports are being submitted as expected.
  It is not intended to be used for everyday development.*/
  //! [1] Crashlytics.
  /// TODO: Uncomment when used Firebase
  // final crashlytics = FirebaseCrashlytics.instance;
  // await crashlytics.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors to Crashlytics.
  // ! [2] Crashlytics.
  /// TODO: Uncomment when used Firebase
  // FlutterError.onError = crashlytics.recordFlutterError;
  // FirebaseCrashlytics.instance.crash();

  runZonedGuarded<Future<void>>(() async {
    try {
      await setupLocator().then(
            (_) async {
          AppLanguageManager appLanguage = locator<AppLanguageManager>();
          await appLanguage.fetchLocale();
          // appLanguage.changeLanguage(const Locale("ar"));

          await SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp]);
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              // status bar color
              statusBarColor: Color(0xffFAFAFA),
              //status bar brightness
              statusBarBrightness: Brightness.dark,
              //status barIcon Brightness
              statusBarIconBrightness: Brightness.dark,
              // navigation bar color
              // systemNavigationBarColor: Color(0xffFAFAFA),
              systemNavigationBarColor: Colors.black,
              //navigation bar icon
              systemNavigationBarIconBrightness: Brightness.light,
              // systemNavigationBarDividerColor: ,
            ),
          );
          // await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

          runApp(
            Root(
              locator: locator,
              child: const ShahowmyApp(),
            ),
          );
        },
        //! [3] Crashlytics.
        /// TODO: Uncomment when used Firebase
        // onError: (error, stackTrace) =>
        //     FirebaseCrashlytics.instance.recordError(error, stackTrace),
      );
    } catch (error) {
      debugPrint("error $error");
    }
  }, (error, stackTrace) {
    debugPrint('runZonedGuarded: Caught error in my root zone. \n$error');

    /// TODO: Uncomment when used Firebase
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class ShahowmyApp extends StatefulWidget {
  // final PendingDynamicLinkData? initialLink;
  const ShahowmyApp({
    Key? key,
    // this.initialLink,
  }) : super(key: key);

  @override
  State<ShahowmyApp> createState() => _ShahowmyAppState();
}

class _ShahowmyAppState extends State<ShahowmyApp> {
  @override
  void initState() {
    super.initState();
    ////////////////////////////////////////////////////////////////////////////
    /// ! PushNotification
    /// TODO: Uncomment when used Firebase
    locator<PushNotificationService>().initialize();
    ////////////////////////////////////////////////////////////////////////////
    /// ! LocalNotification
    /// TODO: Uncomment when used Firebase
    locator<LocalNotificationService>().initializeLocalNotification();
    ////////////////////////////////////////////////////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    final langManager = Provider.of(context)<AppLanguageManager>();
    final navigationService = context.use<NavigationService>();
    final prefs = context.use<PrefsService>();

    /// TODO: Uncomment when used Firebase
    // final analyticsService = context.use<AnalyticsService>();

    return StreamBuilder<Locale>(
        initialData: const Locale('ar'),
        stream: langManager.locale$,
        builder: (context, localeSnapshot) {
          return ScreenUtilInit(
            // designSize: Size(375, 925),
            designSize: const Size(428, 926),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context,child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              color: AppStyle.oil,
              title: 'shahowmy_app',

              builder: (context, widget) {
                //add this line
                // ScreenUtil.setContext(context);
                ScreenUtil.init(context);
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: LifeCycleAwareWidget(
                    child: SafeArea(child: widget!),
                  ),
                );
              },

              //! [6] FirebaseAnalytics.
              navigatorObservers: const <NavigatorObserver>[
                /// TODO: Uncomment when used Firebase
                // analyticsService.getAnalyticsObserver()
              ],
              navigatorKey: navigationService.navigatorKey,
              theme: ThemeData(
                appBarTheme: Theme.of(context)
                    .appBarTheme
                // .copyWith(brightness: Brightness.dark),
                    .copyWith(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                  ),
                ),
                scaffoldBackgroundColor: AppStyle.mainAppColor,
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.grey,
                  selectionColor: Colors.grey,
                  selectionHandleColor: Colors.grey,
                ),
                primarySwatch: AppStyle.appColor,
                fontFamily: 'Cairo',
                // textTheme: GoogleFonts.robotoTextTheme(
                //   Theme.of(context).textTheme,
                // ),
                // primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              locale: localeSnapshot.data,

              // List all of the app's supported locales here
              supportedLocales: const [
                // Locale('en', 'US'),
                Locale('ar', ''),
              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: const [
                // THIS CLASS WILL BE ADDED LATER
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                // if (prefs.appLanguage.isEmpty) {
                //   // Check if the current device locale is supported
                //   for (var supportedLocale in supportedLocales) {
                //     if (supportedLocale.languageCode == locale!.languageCode) {
                //       langManager.changeLanguage(supportedLocale);
                //       prefs.appLanguage = supportedLocale.languageCode;
                //       return supportedLocale;
                //     }
                //   }
                //   // If the locale of the device is not supported, use the first one
                //   // from the list (English, in this case).
                //   langManager.changeLanguage(supportedLocales.first);
                //   prefs.appLanguage = supportedLocales.first.languageCode;
                //
                //   return supportedLocales.first;
                // } else {
                //   return Locale(prefs.appLanguage);
                // }
                return const Locale("ar");
              },

              home: prefs.userObj == null ? const LoginPage():const HomePage(),
              // home: prefs.userObj == null ? const LoginPage():const HomePage(),

              routes: Routes.routes,
            ),
          );
        });
  }
}
