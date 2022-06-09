import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CountDownTimerState();
  }
}

class _CountDownTimerState extends State<CountDownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(minutes: 3));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Countdown(
          animation: StepTween(
            begin: 3 * 60,
            end: 0,
          ).animate(_controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;

  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    onDone();

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 30,
        color: Colors.black,
      ),
    );
  }

  onDone() {
    Duration timeLeft = Duration(seconds: animation.value);

    if (timeLeft.inSeconds == 0) {
      Future.delayed(Duration(milliseconds: 1000), () {
        // if (widget.onDone != null) widget.onDone();
        print('xXx Time is End');
      });
    }
  }
}
