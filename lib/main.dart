import 'package:film_checker/views/account_page_view.dart';
import 'package:film_checker/views/explore_page_view.dart';
import 'package:film_checker/views/home_page_view.dart';
import 'package:film_checker/views/main_app_wrapper.dart';
import 'package:film_checker/views/search_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Checker',
      darkTheme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF252525),
          selectedItemColor: Colors.red,
          selectedLabelStyle: TextStyle(
            color: Colors.red,
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
          seedColor: Colors.red,
          background: const Color(0xFF121212),
        ).copyWith(
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: MainWrapper(),
    );
  }
}
