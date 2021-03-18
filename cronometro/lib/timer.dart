import 'dart:async';

import 'package:cronometro/timer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  int work = 30;
  int breakTime = 5;
  int descanzo  = 15;
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

  Future<void> startWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('trabajo')??30;
              
    _time = Duration(minutes: work);
    _fulltime = _time;
    _isActive = true;
  }

  Future<void>  startBreak() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    breakTime = prefs.getInt('break')??5;
    _time = Duration(minutes: breakTime);
    _fulltime = _time;
    _isActive = true;
  }

  Future<void>  startDescanzo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    descanzo = prefs.getInt('descanzo')??15;
    _time = Duration(minutes: descanzo);
    _fulltime = _time;
    _isActive = true;
  }

  void stop(){
    _isActive = false;
  }

  void restart(){
    _isActive = true;
  }
}
