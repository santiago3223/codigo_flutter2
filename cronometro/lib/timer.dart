import 'dart:async';

import 'package:cronometro/timer_model.dart';

class CountDownTimer {
  int work = 30;
  bool _isActive = false;
  Timer timer;
  double _percentaje=1;
  Duration _time = Duration(seconds: 0);
  Duration _fulltime = Duration(seconds: 0);

  String retornarTiempo(Duration t) {
    String minutos = t.inMinutes < 10
        ? "0" + t.inMinutes.toString()
        : t.inMinutes.toString();
    int seg = t.inSeconds - t.inMinutes * 60;
    String segundos = seg < 10 ? "0" + seg.toString() : seg.toString();
    return minutos + ":" + segundos;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      if (_isActive) {
        _time = _time - Duration(seconds: 1);
        _percentaje = _time.inSeconds / _fulltime.inSeconds;
      }
      if (_time.inSeconds <= 0) {
        _isActive = false;
      }
      return TimerModel(retornarTiempo(_time), _percentaje);
    });
  }

  void startWork() {
    _time = Duration(minutes: work);
    _fulltime = _time;
    _isActive = true;
  }
}
