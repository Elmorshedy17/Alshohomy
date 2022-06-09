import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../app_core.dart';

class Root extends StatelessWidget {
  final Widget child;
  final GetIt locator;

  Root({required this.child, required this.locator});

  @override
  Widget build(BuildContext context) {
    return Provider(
      data: locator,
      child: child,
    );
  }
}
