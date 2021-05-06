import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  String userMail = "";
  TextEditingController controllerCorreo = TextEditingController();
  TextEditingController controllerPwd = TextEditingController();

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print("Cerro Sesion"); //derrepente un navigator a la pantalla de login
        setState(() {
          userMail = "";
        });
      } else {
        print("Inicio Sesion"); //
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              userMail,
            ),
            TextField(
              controller: controllerCorreo,
              decoration: InputDecoration(hintText: "correo"),
            ),
            TextField(
              controller: controllerPwd,
              decoration: InputDecoration(hintText: "password"),
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: controllerCorreo.text,
                          password: controllerPwd.text)
                      .then((user) {
                    setState(() {
                      userMail = user.user.email;
                    });
                  }).catchError((e) => print(e));
                },
                child: Text("Registrar")),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: controllerCorreo.text,
                          password: controllerPwd.text)
                      .then((user) {
                    setState(() {
                      userMail = user.user.email;
                    });
                  }).catchError((e) => print(e));
                },
                child: Text("Iniciar Sesion")),
            ElevatedButton(
                onPressed: () async {
                  GoogleSignInAccount googleUser =
                      await GoogleSignIn().signIn();
                  GoogleSignInAuthentication googleAuth =
                      await googleUser.authentication;

                  var credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken);

                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((user) {
                    setState(() {
                      userMail = user.user.email;
                    });
                  }).catchError((e) => print(e));
                },
                child: Text("Iniciar Sesion GOOGLE")),
                ElevatedButton(
                onPressed: () async {
                  LoginResult loginResult  = await FacebookAuth.instance.login();
                  
                  var credential = FacebookAuthProvider.credential(loginResult.accessToken.token);

                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((user) {
                    setState(() {
                      userMail = user.user.email;
                    });
                  }).catchError((e) => print(e));
                },
                child: Text("Iniciar Sesion FACEBOOK")),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    setState(() {
                      userMail = "";
                    });
                  });
                },
                child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}
