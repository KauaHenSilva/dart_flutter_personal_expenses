import 'package:dart_flutter_despesas_pessoais/screens/home_page.dart';
import 'package:dart_flutter_despesas_pessoais/utils/my_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routes: {
        MyRoutes.home: (context) => const HomePage(),
      },
    );
  }
}
