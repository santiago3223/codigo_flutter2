import 'package:flutter/material.dart';
import 'package:flutter_culqi/flutter_culqi.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _publicKey = 'pk_test_i9MhwOiza9JFguT7';
    CulqiCard card = CulqiCard(
        cardNumber: '4111111111111111',
        cvv: '123',
        expirationMonth: 9,
        expirationYear: 2025,
        email: 'test@testmail.com');
    CulqiTokenizer tokenizer = CulqiTokenizer(card);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await tokenizer.getToken(publicKey: _publicKey);
          if (result is CulqiToken) {
            print(result.token);
            var url = Uri.parse('https://api.culqi.com/v2/charges');
            var response = await http.post(url, headers: {
              "Accept": "application/json",
              "authorization": "pk_test_vzMuTHoueOMlgUPj"
            }, body: {
              "amount": "1000",
              "currency_code": "PEN",
              "email": "TEST@CULQI",
              "source_id": "tkn_test_vzMuTHoueOMlgUPj"
            });
            print(response.body);
          } else if (result is CulqiError) {
            print(result);
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
