import 'dart:io';

import 'package:film_checker/app_theme.dart';
import 'package:film_checker/main_app_wrapper.dart';
import 'package:film_checker/support/my_http_overrides.dart';
import 'package:film_checker/views/anime_watch_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  prefs = await SharedPreferences.getInstance();

  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appTheme = AppTheme();

  @override
  void initState() {
    super.initState();
    _appTheme.addListener(() => setState(() {}));
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );

    if (prefs.getString('theme') != null) {
      switch (prefs.getString('theme')) {
        case 'dark':
          AppTheme().enableTheme('dark', context);
          break;
        case 'light':
          AppTheme().enableTheme('dark', context);
          break;
        case 'system':
          AppTheme().enableTheme('dark', context);
          break;
      }
    } else {
      AppTheme().enableTheme('dark', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime Watchers',
      theme: _appTheme.lightTheme,
      darkTheme: _appTheme.darkTheme,
      themeMode: _appTheme.themeMode,
      home: const MainWrapper(),
    );
  }
}
