import 'package:cronometro/timer.dart';
import 'package:cronometro/timer_model.dart';
import 'package:cronometro/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'settings.dart';

class TimerHomePage extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> Settings()));
        })],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Trabajo",
                        color: Colors.green.shade800,
                        onPressed: () {
                          timer.startWork();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Break",
                        color: Colors.blueGrey,
                        onPressed: () {
                          timer.startBreak();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Descanzo",
                        color: Colors.blueGrey.shade700,
                        onPressed: () {
                          timer.startDescanzo();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                initialData: TimerModel("00:00", 1),
                stream: timer.stream(),
                builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                TimerModel timer = snapshot.data;
                return Expanded(
                  child: CircularPercentIndicator(
                    radius: constraints.maxWidth / 1.5,
                    percent: timer.percent,
                    lineWidth: 10,
                    progressColor: Colors.green.shade800,
                    center: Text(
                      timer.time,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                );
              }),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Stop",
                        color: Colors.blueGrey.shade900,
                        onPressed: () {
                          timer.stop();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Restart",
                        color: Colors.green.shade800,
                        onPressed: () {
                          timer.restart();
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
