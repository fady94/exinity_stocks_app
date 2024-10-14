import 'package:exinity_app/core/routing/app_routes.dart';
import 'package:exinity_app/features/app/presentation/pages/splash_screen.dart';
import 'package:exinity_app/features/stocks/presentation/pages/search_screen.dart';
import 'package:exinity_app/features/stocks/presentation/pages/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.splashScreen.path,
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen.name,
        path: AppRoutes.splashScreen.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.homeScreen.name,
        path: AppRoutes.homeScreen.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoutes.searchScreen.name,
        path: AppRoutes.searchScreen.path,
        builder: (context, state) => const SearchScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    ),
  );
}
