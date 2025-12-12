import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jothikrishnan | Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
