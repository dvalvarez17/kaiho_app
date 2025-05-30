import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaiho_app/screens/login_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, stare) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) {
          final user = FirebaseAuth.instace.currentUser;

          if (user == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');
            });
          }

          return Scaffold(
            body: child,
            bottomNavigationBar: NavBar(
              currentIndex: _getCurrentIndex(state.uri.toString()),
              onTabSelected: (index) {
                switch (index) {
                  case 0:
                    context.go('/home_page');
                  case 1:
                    context.go();
                }
              },
            ),
          );
        },
        routes: [
          GoRoute(path: '/home_page', builder: (context, state) => HomePage()), 
        ],
      ),
    ],
  );

  static int _getCurrentIndex(String? location) {
    switch (location) {
      case '/login':
        return 0;
      case 'home_page':
        return 1;
    }
  }
}
