
import 'package:flutter/material.dart';
import 'package:pr2/main.dart';
import 'package:pr2/presentation/RegLayout.dart';

const registrationScreen = 'regScreen';
const loginScreen = 'logScreen';
const userScreen = 'userScreen';
const adminScreen = 'adminScreen';

class AppRouter{

  Route<dynamic>? generataRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){

      case registrationScreen:
        return MaterialPageRoute(builder: (_) => Registration());

      // case loginScreen:
      //   return MaterialPageRoute(builder: (_) => Login());
    }
  }
}