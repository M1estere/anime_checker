import 'dart:io';

import 'package:film_checker/app_theme.dart';
import 'package:film_checker/support/string_extension.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:flutter/material.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  final TextEditingController _nicknameController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        toolbarHeight: 50,
        title: Text(
          'Settings'.capitalize(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: !_isLoading
          ? SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .22,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    'profile'.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.grey.withOpacity(.3),
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      height: 45,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Log Out',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.grey.withOpacity(.3),
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      height: 45,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Change profile picture',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.grey.withOpacity(.3),
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      height: 62,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Change nickname',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            'M1estere',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                            thickness: 1.2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    'app'.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.grey.withOpacity(.3),
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      height: 65,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Change app theme',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            AppTheme()
                                                .themeMode
                                                .toString()
                                                .replaceAll('ThemeMode.', '')
                                                .capitalize(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 75,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'AniScape',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                'v1.0.1',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const FetchingCircle(),
    );
  }
}
