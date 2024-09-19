import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/Anuncios.dart';
import 'package:myapp/Login.dart';
import 'firebase_options.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xFFe52755),
  hintColor: Color(0xFFfad107),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //inicializa a ligação Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: "Online Shop",
    home: Anuncios(),
    theme: temaPadrao,
    debugShowCheckedModeBanner: false,
  ));
}
