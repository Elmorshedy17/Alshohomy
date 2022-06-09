import 'package:get_it/get_it.dart';
import 'package:shahowmy_app/app_core/fcm/FcmTokenManager.dart';
import 'package:shahowmy_app/app_core/fcm/localNotificationService.dart';
import 'package:shahowmy_app/app_core/fcm/pushNotification_service.dart';
import 'package:shahowmy_app/features/choose_language/choose_language_manager.dart';
import 'package:shahowmy_app/features/contacts/contacts_manager.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_manager.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:shahowmy_app/features/login/login_manager.dart';
import 'package:shahowmy_app/features/operation_files/files_operaations_manager.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operaations_info_manager.dart';
import 'package:shahowmy_app/features/operations/operations_post/operations_post_manager.dart';

import 'app_core.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance!);


  /// AppLanguageManager
  locator.registerLazySingleton<AppLanguageManager>(() => AppLanguageManager());

  // /// AddAddressCheckOutManager
  // locator.registerLazySingleton<AddAddressCheckOutManager>(
  //     () => AddAddressCheckOutManager());

  // /// FcmTokenManager
  locator.registerLazySingleton<FcmTokenManager>(() => FcmTokenManager());
  //
  // /// AnalyticsService
  // locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  //

  // /// LocalNotificationService
  // locator.registerLazySingleton<LocalNotificationService>(
  //         () => LocalNotificationService());
  // //
  // // /// PushNotificationService
  // locator.registerLazySingleton<PushNotificationService>(
  //         () => PushNotificationService());

  /// LoadingManager
  locator.registerLazySingleton<LoadingManager>(() => LoadingManager());

  /// ApiService
  locator.registerLazySingleton<ApiService>(() => ApiService());

  /// ToastTemplate
  locator.registerLazySingleton<ToastTemplate>(() => ToastTemplate());


  /// NavigationService
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  /// ChooseLanguageManager
  locator.registerLazySingleton<ChooseLanguageManager>(
      () => ChooseLanguageManager());

  /// HomeManager
  locator.registerLazySingleton<HomeManager>(
      () => HomeManager());

  /// LoginManager
  locator.registerLazySingleton<LoginManager>(
      () => LoginManager());

  /// SearchInfoManager
  locator.registerLazySingleton<SearchInfoManager>(
      () => SearchInfoManager());

  /// OperationsInfoManager
  locator.registerLazySingleton<OperationsInfoManager>(
      () => OperationsInfoManager());


  /// OperationsPostManager
  locator.registerLazySingleton<OperationsPostManager>(
      () => OperationsPostManager());


  /// OperationFilesManager
  locator.registerLazySingleton<OperationFilesManager>(
      () => OperationFilesManager());

  /// ContactsInfoManager
  locator.registerLazySingleton<ContactsInfoManager>(
      () => ContactsInfoManager());

  /// PushNotificationService
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());

  /// LocalNotificationService
  locator.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

}
