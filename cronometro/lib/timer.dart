import 'dart:async';

import 'package:cronometro/timer_model.dart';

class CountDownTimer{
  int work = 30;
  bool _isActive = true;
  Timer timer;
  double _percentaje;
  Duration _time;
  Duration _fulltime;

  String retornarTiempo(Duration t){
    String minutos = t.inMinutes<10?"0"+t.inMinutes.toString():t.inMinutes.toString();
    String segundos = t.inSeconds<10?"0"+t.inSeconds.toString():t.inSeconds.toString();
    return minutos+":"+segundos;
  }

  Stream<TimerModel> stream() async*{
    yield * Stream.periodic(Duration(seconds: 1), (int a) {
      _time = _time - Duration(seconds: 1);
      _percentaje = _time.inSeconds / _fulltime.inSeconds;
      if(_time.inSeconds <=0){
        _isActive = false;
      }

      return TimerModel(retornarTiempo(_time), _percentaje);

    });
  }

  void startWork(){
    _time = Duration(minutes: work);
    _fulltime = _time;
  }
  
}