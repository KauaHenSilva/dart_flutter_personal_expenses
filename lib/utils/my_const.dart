class MyConst {
  String urlBase = const String.fromEnvironment("URL_BASE");

  String get urlTransactions => '$urlBase/transactions';
}
