import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobigic_test/Screens/grid_input_screen.dart';
import 'package:mobigic_test/Screens/splash_screen.dart';
import 'package:mobigic_test/router.dart';
import 'package:mobigic_test/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: defaultTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // timer for displaying next screen
    Timer(const Duration(milliseconds: 4000),()=>Navigator.pushReplacementNamed(context, GridInputScreen.routeName));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
