import 'package:flutter/material.dart';
import 'package:shahowmy_app/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:shahowmy_app/features/contacts/contacts_page.dart';
import 'package:shahowmy_app/features/home/home_page.dart';
import 'package:shahowmy_app/features/login/login_page.dart';
import 'package:shahowmy_app/features/main_tabs/main_tabs_widget.dart';
import 'package:shahowmy_app/features/web_view_page/web_view_page.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // AppRoutesNames.mainTabsWidget: (_) => const MainTabsWidget(),
    AppRoutesNames.loginPage: (_) => const LoginPage(),
    AppRoutesNames.homePage: (_) => const HomePage(),
    AppRoutesNames.contactsPage: (_) => const ContactsPage(),
    AppRoutesNames.webViewPage: (_) => const WebViewPage(),
  };
}
