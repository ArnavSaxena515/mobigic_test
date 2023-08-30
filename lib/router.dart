import 'package:flutter/material.dart';
import 'package:mobigic_test/Screens/grid_input_screen.dart';
import 'package:mobigic_test/Screens/word_grid_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case(WordGridScreen.routeName):
      var dimensions = routeSettings.arguments as Map<String,int>;
      return MaterialPageRoute(builder: (_)=> WordGridScreen(dimensions:dimensions));

    case(GridInputScreen.routeName):
      return MaterialPageRoute(builder: (_)=>const GridInputScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Screen does not exist"),
            ),
          ));
  }


}