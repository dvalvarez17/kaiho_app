import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaiho_app/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return RepositoryProvider(
      // TODO: RepositoryProvider<AuthRepository>
      create: (context) => {}, // TODO: create: (context) => AuthRepository()
      child: BlocProvider(
        // TODO: Cuando se tenta el provider de login, se indica
        // BlocProvider<AuthBloc>
        create:
            (context) =>
                {}, // TODO: el contexto llamará al Repsoctorio configurado. Ej. AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context))
        child: MaterialApp(
          theme: AppThemes.kaihoLightTheme,
          darkTheme: AppThemes.kaihoDarkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const Scaffold(body: Center(child: Text('Hello World!'))),
        ),
      ),
    );
  }
}
