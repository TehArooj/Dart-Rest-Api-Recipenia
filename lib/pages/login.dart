import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rest_api/models/userstate.dart';
import 'package:rest_api/constants/firebase-service.dart';
import 'package:rest_api/pages/homepage.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Recipina'),
        //   // removes back button
        //   automaticallyImplyLeading: false,
        // ),
        body: Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Image.asset(
                    "images/icon.png",
                    height: 180,
                  ),
                ),
                Text(
                  "RecipeApp",
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  "Find Deliciously Awesome Recipies",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Consumer<UserModel>(
          builder: (context, user, child) {
            return Container(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.purple,
                ),
                child: const Text('Login With Google'),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Firebase.initializeApp();

                  FirebaseService service = FirebaseService();
                  try {
                    var u = await service.signInwithGoogle();
                    user.setUser(u);
                    print("tintin");

                    Navigator.pushReplacementNamed(context, '/homepage');

                    //Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                  } catch (e) {
                    if (e is FirebaseAuthException) {
                      print("Hello");
                    }
                  }
                  setState(
                    () {
                      isLoading = false;
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    ));
  }
}
