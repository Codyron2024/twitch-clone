import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_cubit.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_state.dart';
import 'package:twitch_clone/src/feature/authentication/login/login_screen.dart';
import 'package:twitch_clone/src/feature/authentication/signup/signup_screen.dart';
import 'package:twitch_clone/src/feature/bottomnavbar/bottomnavbar.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/broadcast_screen.dart';
import 'package:twitch_clone/src/feature/golive/ui/golive_screen.dart';
import 'package:twitch_clone/src/feature/home/ui/homescreen.dart';
import 'package:twitch_clone/src/feature/onboarding/ui/onboardingscreen.dart';
import 'package:twitch_clone/src/feature/splash/splash_screen.dart';
import 'package:twitch_clone/src/injection.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:twitch_clone/src/utils/utils.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: Pagename.splashRoute,
    routes: [
      ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return Bottomnavbar(child: child);
          },
          routes: [
            GoRoute(
              path: Pagename.homeRoute,
              pageBuilder : (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child: Homescreen()),
            ),
            GoRoute(
              path: Pagename.goliveRoute,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child:  Golivescreen()),
            ),
            // GoRoute(
            //   path: Pagename.broadcastRoute,
            //   pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            //   context: context, state: state, child: const Broadcastscreen()),
            // ),
          ]),
      GoRoute(
          path: Pagename.loginRoute,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child: const Loginscreen())),
      GoRoute(
          path: Pagename.onboardingRoute,
          builder: (context, state) => const OnboardingScreen()),
      GoRoute(
          path: Pagename.splashRoute,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child: const Splashscreen())),
          GoRoute(
          path: Pagename.signupRoute,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child: const SignupScreen())),
    ]);

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
