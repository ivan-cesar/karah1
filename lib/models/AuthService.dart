import 'package:canteen_food_ordering_app/screens/login.dart';
import 'package:canteen_food_ordering_app/screens/navigationBar.dart';
import 'package:canteen_food_ordering_app/screens/splash_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService {
  //Gérer l'authentification
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SplashContent();
          } else {
            return LoginPage();
          }
        });
  }

  //Déconnexion
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //S'identifier
  signIn(email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print('Connecté');
    }).catchError((e){
      print(e);
    });
  }
}
