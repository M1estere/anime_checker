import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  static final _instance = AppTheme._();

  AppTheme._();

  factory AppTheme() {
    return _instance;
  }

  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => ThemeData(
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          selectedLabelStyle: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        cardColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 0,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          outlineBorder: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
          hintStyle: TextStyle(
            color: Color(0xFFA2A2A2),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),
          prefixIconColor: Color(0xFFA2A2A2),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          background: Colors.white,
        ).copyWith(
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      );

  ThemeData get darkTheme => ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF252525),
          selectedItemColor: Colors.blue,
          selectedLabelStyle: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        cardColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 0,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: Color(0xFF252525),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          outlineBorder: BorderSide.none,
          hintStyle: TextStyle(
            color: Color(0xFFA2A2A2),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),
          prefixIconColor: Color(0xFFA2A2A2),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          background: const Color(0xFF121212),
        ).copyWith(
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      );

  enableTheme(String name, BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', name);

    switch (name) {
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'system':
        _themeMode = ThemeMode.system;
        break;
    }

    notifyListeners();
  }
}
