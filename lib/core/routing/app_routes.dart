/// Represents the app routes and their paths.
enum AppRoutes {
  splashScreen(
    name: 'SPLASH_SCREEN',
    path: '/splash-screen',
  ),
  homeScreen(
    name: 'HOME_SCREEN',
    path: '/home',
  ),
  searchScreen(
    name: 'SEARCH_SCREEN',
    path: '/search',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  ///
  /// Example: `AppRoutes.home.name`
  /// Returns: 'HOME'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.home.path`
  /// Returns: '/home'
  final String path;

  @override
  String toString() => name;
}
