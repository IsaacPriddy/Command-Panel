import 'package:flutter/material.dart';
import 'screens/play_screen.dart';
/*
  // Official colors and info that I cannot use at this time
    // Tan color: #f8e9d5 rgba(233,220,202,255)
    // Blue color: #0c4483 rgba(13,69,132,255)
    // Red color: #a80506 rgba(168,5,6,255)
    // Text theme: Nuffle (I would need to download this from elsewhere and put it in the pubspec.yaml to make it actually work)
*/

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  static final routes = {
    '/': (context) => const CircularProgressIndicator(),
    'Play Screen': (context) => const PlayScreen(),
    // Maybe a dice roller for those who want one?
      // Or put it on the play screen as an option
  };

  @override
  AppState createState() => AppState();
}

class AppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Command Panel',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueGrey.shade500),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Aquire',
            fontSize: 24.0, 
          ), // What the appbar uses by default
        )
      ),
      routes: MyApp.routes,
      initialRoute: 'Play Screen',
    );
  }
}