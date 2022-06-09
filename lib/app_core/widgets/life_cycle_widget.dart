import 'package:flutter/material.dart';

class LifeCycleAwareWidget extends StatefulWidget {
  final Widget child;

  const LifeCycleAwareWidget({Key? key, required this.child}) : super(key: key);
  @override
  _LifeCycleAwareWidgetState createState() => _LifeCycleAwareWidgetState();
}

class _LifeCycleAwareWidgetState extends State<LifeCycleAwareWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('LifeCycleState = $state');
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
