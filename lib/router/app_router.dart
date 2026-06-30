import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecomerceapp/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecomerceapp/features/auth/presentation/screens/login_screen.dart';
import 'package:ecomerceapp/features/auth/presentation/screens/signup_screen.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: RouteNames.store,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Store - Coming Soon')),
      ),
    ),
  ],
);