import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Provider extends InheritedWidget {
  final GetIt data;

  const Provider({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  static GetIt of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())!.data;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

extension ProviderExtension<T extends Object> on BuildContext {
  // ignore: avoid_shadowing_type_parameters
  T use<T extends Object>() => Provider.of(this)<T>();
}
