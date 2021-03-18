import 'package:cronometro/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      body: Container(
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
            Expanded(
              child: CircularPercentIndicator(
                radius: 200,
                percent: 0.5,
                lineWidth: 10,
                progressColor:Colors.green.shade800 ,
                center: Text("00:00"),
              ),
            ),
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
    );
  }
}
