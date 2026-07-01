import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecomerceapp/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecomerceapp/features/auth/presentation/screens/login_screen.dart';
import 'package:ecomerceapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:ecomerceapp/features/products/presentation/screens/store_listing_screen.dart';
import 'route_names.dart';
import 'package:ecomerceapp/features/products/presentation/screens/product_detail_screen.dart';
import 'package:ecomerceapp/features/products/presentation/screens/category_product_screen.dart';
import 'package:ecomerceapp/features/products/presentation/screens/category_listing_screen.dart';


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
      builder: (context, state) => const StoreListingScreen(),
    ),
    GoRoute(
      path: RouteNames.productDetail,
      builder: (context, state) {
        final productId = state.extra as int;
        return ProductDetailScreen(productId:productId);
      }
    ),
     GoRoute(
      path: RouteNames.categories,
      builder: (context, state) => const CategoryListingScreen(),
    ),
    GoRoute(
      path: RouteNames.categoryProducts,
      builder: (context, state) {
        final category = state.extra as String;
        return CategoryProductScreen(category: category);
      }
    ),
  ],
);