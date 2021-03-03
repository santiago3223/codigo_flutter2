import 'package:flutter/material.dart';

class Ejercicio1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://static.businessworld.in/article/article_extra_large_image/1520586649_m0xkGj_jack-daniels-2018-scout-bobber.jpg",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                  Text("Sign in to continue",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 30),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.white60),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54))),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white60),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54))),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Forgot yout password?",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Sign  in "),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Dont have an account? SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
