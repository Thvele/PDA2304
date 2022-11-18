import 'package:flutter/material.dart';
import 'package:pr2/app_route.dart';
import 'package:pr2/core/db/database_helper.dart';

void main() {

  runApp(const App());
}

class App extends StatelessWidget {
  
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    AppRouter appRouter = AppRouter();

    return MaterialApp(

      onGenerateRoute: appRouter.generataRoute,
      initialRoute: registrationScreen,
    );
  }
}