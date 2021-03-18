import 'package:cronometro/timer.dart';
import 'package:cronometro/timer_model.dart';
import 'package:cronometro/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
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
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Break",
                        color: Colors.blueGrey,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Descanzo",
                        color: Colors.blueGrey.shade700,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: timer.stream(),
                builder: (context, snapshot) {
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
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerButton(
                        text: "Restart",
                        color: Colors.green.shade800,
                        onPressed: () {},
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
