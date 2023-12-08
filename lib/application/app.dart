
import 'package:flutter/material.dart';
import 'package:spotify_clone/application/theme.dart';
import 'package:spotify_clone/presentation/home/home_screen.dart';
import 'package:spotify_clone/presentation/resources/route_manager.dart';

import '../presentation/album/album_screen.dart';
import '../presentation/home/home.dart';
import '../presentation/song/song_screen.dart';


class MyApp extends StatefulWidget {

  const MyApp._internal(); //private named constructor

  static const MyApp instance = MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance;  // factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: theme,
      title: 'Spotify',
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.homeScreenRoute,
      // onGenerateRoute: RouteGenerator.getRoute,
      // initialRoute: Routes.splashRoute,
    );
  }
}