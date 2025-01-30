import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Widget timerText = Text('60 seconds remaining');
  late Timer _timer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
        timerText = Text('$_remainingSeconds ');
      });
      if (_remainingSeconds == 0) {
        _timer.cancel();
        setState(() {
          timerText = TextButton( onPressed: ()
          {
            _remainingSeconds = 60;
            _startTimer();
          }, child: Text(S.of(context).resend,style: TextStyle(color: AppColor.main),),);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: timerText,

    );
  }
}