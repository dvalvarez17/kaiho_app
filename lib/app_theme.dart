import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData kaihoLightTheme = ThemeData(
    // Colores principales.
    primaryColor: const Color(0xFFFFFFFF),
    primaryColorLight: const Color(0xF2FFFFFF),
    primaryColorDark: const Color(0xFF303030),
    fontFamily: 'Gotham Cond Medium',
    // Esquema de colores globales.
    colorScheme: ColorScheme.light(
      primary: Color(0xFF233F2E),
      error: Color(0xFFD32F2F),
      onPrimary: Colors.white,
    ),
    // Esquema de colores para textos.
    textTheme: const TextTheme(
      // Encabezado grande
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF233F2E),
      ),
      // Subtítulos.
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF233F2E),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFF233F2E),
      ),
      // Texto secundario
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFF233F2E),
      ),
      // Anotaciones.
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFF233F2E),
      ),
    ),
    // Estilo de los botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF233F2E),
        foregroundColor: const Color(0xFFFFFFFF),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF1F8E9),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF233F2E)),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF233F2E),
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF233F2E)),
    dividerColor: const Color(0xFF303030),
  );

  static final ThemeData kaihoDarkTheme = ThemeData(
    // Colores principales.
    primaryColor: const Color(0xFFFFFFFF),
    primaryColorLight: const Color(0xF2FFFFFF),
    primaryColorDark: const Color(0xFF303030),
    fontFamily: 'Gotham Cond Medium',
    scaffoldBackgroundColor: Color(0xFF303030),
    // Esquema de colores globales.
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFF233F2E),
    ),
    // Esquema de colores para textos.
    textTheme: const TextTheme(
      // Encabezado grande
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
      // Subtítulos.
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFFFFFFFF),
      ),
      // Texto secundario
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFFFFFFFF),
      ),
      // Anotaciones.
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFFFFFFFF),
      ),
    ),
    // Estilo de los botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xE6233F2E),
        foregroundColor: const Color(0xFFFFFFFF),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF1F8E9),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF233F2E)),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF233F2E),
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF233F2E)),
    dividerColor: const Color(0xFF303030),
  );
}
