import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SGE',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}
