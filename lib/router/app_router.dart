import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Login')),
      ),
    ),
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Signup')),
      ),
    ),
  ],
);