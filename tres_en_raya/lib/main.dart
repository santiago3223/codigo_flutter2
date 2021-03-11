import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TresEnRaya(),
    );
  }
}

class TresEnRaya extends StatefulWidget {
  @override
  _TresEnRayaState createState() => _TresEnRayaState();
}

class _TresEnRayaState extends State<TresEnRaya> {
  List<String> botones = ["", "", "", "", "", "", "", "", ""];
  bool turno_jugador_1 = true;
  bool multijugador = false;
  int ganador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tres en raya")),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Un Jugador"),
                Switch(
                    value: multijugador,
                    onChanged: (b) {
                      setState(() {
                        multijugador = b;
                      });
                    }),
                Text("Multijugador")
              ],
            ),
            Text(
              "Numero de partida: 100",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child: ListTile(
                        title: Text(
                          "0",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          "Jugador 1",
                          textAlign: TextAlign.center,
                        ))),
                Expanded(
                    child: Text(
                        "Turno: Jugador" + (turno_jugador_1 ? "1" : "2"),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5)),
                Expanded(
                    child: ListTile(
                        title: Text(
                          "0",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          "Jugador 2",
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            obtenerBotones(context),
            ganador == 0
                ? Container()
                : Text("Gano Jugador $ganador",
                    style: Theme.of(context).textTheme.headline4),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  reiniciar();
                },
                child: Text("Reiniciar"))
          ],
        ),
      ),
    );
  }

  Widget obtenerBotones(context) {
    return Expanded(
      child: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: botones
            .asMap()
            .map(
              (i, e) => MapEntry(
                i,
                ElevatedButton(
                  onPressed: () {
                    presionoBoton(i);
                  },
                  child: e == "X"
                      ? Icon(
                          Icons.close,
                          size: 45,
                        )
                      : e == "O"
                          ? Icon(
                              Icons.lens_outlined,
                              size: 45,
                            )
                          : Text(""),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }

  void reiniciar() {
    setState(() {
      botones = ["", "", "", "", "", "", "", "", ""];
      turno_jugador_1 = true;
      ganador = 0;
    });
  }

  void presionoBoton(int i) {
    if (botones[i] == "") {
      setState(() {
        botones[i] = turno_jugador_1 ? "X" : "O";
        if (verificarGanador(botones)) {
          setState(() {
            ganador = turno_jugador_1 ? 1 : 2;
          });
        }
        turno_jugador_1 = !turno_jugador_1;
      });
      if (!multijugador && !turno_jugador_1) {
        presionoBoton(obtenerMejorJugada());
      }
    }
  }

  int obtenerMejorJugada() {
    List mm = minimax(botones, turno_jugador_1);

    return mm[1];
  }

  bool verificarGanador(botones) {
    List pos_ganadoras = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [6, 4, 2]
    ];
    for (List pos in pos_ganadoras) {
      bool hay_ganador = true;
      String signo = botones[pos[0]];

      for (int s in pos) {
        if (signo != botones[s] || signo == "") {
          hay_ganador = false;
        }
      }

      if (hay_ganador) {
        return true;
      }
    }
    return false;
  }

  List minimax(board, player) {
    if (verificarGanador(board)) {
      return [1, 0];
    }

    int move = -1;
    int score = -2;

    for (var i = 0; i < board.length; ++i) {
      if (board[i] == "") {
        List boardWithNewMove = List.from(board);
        boardWithNewMove[i] = player ? "X" : "O";
        List mm = minimax(boardWithNewMove, !player);
        int scoreForTheMove = -mm[0];
        if (scoreForTheMove > score) {
          score = scoreForTheMove;
          move = i;
        }
      }

    }
    if (move == -1) {
      return [0, -1];
    }
    return [score, move];
  }
}
