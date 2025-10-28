import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24402F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            // Logo central (isotipo)
            Image.asset(
              'assets/images/kaiho-balnco.png',
              width: 200,
              height: 200,
            ),
            const Spacer(flex: 2),
            // Logo inferior (branding)
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Image.asset(
                'assets/images/isotipo-kaiho-espiral-blanco.png',
                width: 199,
                height: 66,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
