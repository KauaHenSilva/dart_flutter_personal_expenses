import 'package:dart_flutter_despesas_pessoais/models/transactions_list.dart';
import 'package:dart_flutter_despesas_pessoais/screens/graphic_page.dart';
import 'package:dart_flutter_despesas_pessoais/screens/home_page.dart';
import 'package:dart_flutter_despesas_pessoais/screens/transactions_form.dart';
import 'package:dart_flutter_despesas_pessoais/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionsList()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        ...FormBuilderLocalizations.supportedLocales,
      ],
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        FormBuilderLocalizations.delegate,
      ],
      title: 'Personal expenses',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routes: {
        MyRoutes.home: (context) => const HomePage(),
        MyRoutes.addTransaction: (context) => const TransactionsForm(),
        MyRoutes.graphic: (context) => const GraphicPage(),
      },
    );
  }
}
