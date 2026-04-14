enum AppRoutes {
  history(path: '/'),
  quiz(path: '/quiz'),
  result(path: '/result');

  const AppRoutes({required this.path});

  final String path;
}
