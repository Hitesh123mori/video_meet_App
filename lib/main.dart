import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' ;
import 'package:zoom_clone/screens/splash_screen.dart';
import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized() ;
  await _intializeFirebase() ;
  runApp(myApp()) ;
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Zoom",
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}

_intializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
