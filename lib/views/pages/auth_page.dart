import 'package:film_checker/firebase/auth_provider.dart';
import 'package:film_checker/main_app_wrapper.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:flutter/material.dart';

enum PasswordFormState {
  login,
  register,
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _registerNickname = TextEditingController();
  final TextEditingController _registerEmail = TextEditingController();
  final TextEditingController _registerPassword = TextEditingController();
  final TextEditingController _registerConfirmPassword =
      TextEditingController();

  final TextEditingController _loginEmail = TextEditingController();
  final TextEditingController _loginPassword = TextEditingController();

  final PageController _pageController = PageController();
  bool _signInOpened = true;

  bool _regPasswordVisible = false;
  bool _logPasswordVisible = false;

  String _regErrorText = '';
  bool _hasRegError = false;

  String _logErrorText = '';
  bool _hasLogError = false;

  bool _sendingData = false;

  @override
  void dispose() {
    super.dispose();

    _registerNickname.dispose();
    _registerEmail.dispose();
    _registerPassword.dispose();
    _registerConfirmPassword.dispose();

    _loginEmail.dispose();
    _loginPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: const Text(
          'AniLibria',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        _signInOpened = true;
                        _pageController.animateToPage(
                          0,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color:
                              _signInOpened ? Colors.blue : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: _signInOpened
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: _signInOpened ? 22 : 20,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        _signInOpened = false;
                        _pageController.animateToPage(
                          1,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color:
                              !_signInOpened ? Colors.blue : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: !_signInOpened
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: !_signInOpened ? 22 : 20,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 330,
            child: PageView(
              controller: _pageController,
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                if (mounted) {
                  setState(() {
                    _signInOpened = value == 1 ? false : true;
                  });
                }
              },
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _authField(
                        _loginEmail,
                        'Enter your email...',
                        Icons.person,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _passwordAuthField(
                        _loginPassword,
                        PasswordFormState.login,
                        'Enter a password...',
                        Icons.key,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _hasLogError
                          ? _displayError(_logErrorText)
                          : const Center(),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                        child: InkWell(
                          onTap: () {
                            if (_sendingData) return;

                            if (_loginEmail.text.trim().isEmpty ||
                                _loginPassword.text.trim().isEmpty) {
                              if (mounted) {
                                setState(() {
                                  _hasLogError = true;
                                  _logErrorText = 'Fill all fields';
                                });
                              }
                              return;
                            }

                            setState(() {
                              _logErrorText = '';
                              _sendingData = true;
                            });

                            AuthProvider()
                                .signIn(
                              _loginEmail.text.trim(),
                              _loginPassword.text.trim(),
                            )
                                .then(
                              (value) {
                                if (mounted) {
                                  switch (value) {
                                    case 0: // all good
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainWrapper(),
                                        ),
                                      );
                                      break;
                                    case 1:
                                      setState(() {
                                        _hasLogError = true;
                                        _logErrorText = 'User not found';
                                        _sendingData = false;
                                      });
                                      break;
                                    case 2:
                                      setState(() {
                                        _hasLogError = true;
                                        _logErrorText = 'Wrong password';
                                        _sendingData = false;
                                      });
                                      break;
                                    case 3:
                                      setState(() {
                                        _hasLogError = true;
                                        _logErrorText = 'Invalid email';
                                        _sendingData = false;
                                      });
                                      break;
                                    case 4:
                                      setState(() {
                                        _hasLogError = true;
                                        _logErrorText = 'Something went wrong';
                                        _sendingData = false;
                                      });
                                      break;
                                  }
                                }
                              },
                            );
                          },
                          splashColor: Colors.blue.withOpacity(.6),
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Sign In'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _authField(
                        _registerNickname,
                        'Enter your nickname...',
                        Icons.person,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _authField(
                        _registerEmail,
                        'Enter your email...',
                        Icons.mail,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _passwordAuthField(
                        _registerPassword,
                        PasswordFormState.register,
                        'Enter a password...',
                        Icons.key,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _authField(
                        _registerConfirmPassword,
                        'Confirm a password',
                        Icons.verified_rounded,
                        obscure: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _hasRegError
                          ? _displayError(_regErrorText)
                          : const Center(),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                        child: InkWell(
                          onTap: () {
                            if (_sendingData) return;

                            if (_registerPassword.text.trim() !=
                                _registerConfirmPassword.text.trim()) {
                              if (mounted) {
                                setState(() {
                                  _hasRegError = true;
                                  _regErrorText = 'Passwords mismatch';
                                });
                              }
                              return;
                            }

                            if (_registerEmail.text.trim().isEmpty ||
                                _registerPassword.text.trim().isEmpty ||
                                _registerConfirmPassword.text.trim().isEmpty ||
                                _registerNickname.text.trim().isEmpty) {
                              if (mounted) {
                                setState(() {
                                  _hasRegError = true;
                                  _regErrorText = 'Fill all fields';
                                });
                              }
                              return;
                            }

                            setState(() {
                              _regErrorText = '';
                              _sendingData = true;
                            });

                            AuthProvider()
                                .registerUser(
                              _registerEmail.text.trim(),
                              _registerPassword.text.trim(),
                              _registerNickname.text.trim(),
                            )
                                .then(
                              (value) {
                                if (mounted) {
                                  switch (value) {
                                    case 0: // all good
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainWrapper(),
                                        ),
                                      );
                                      break;
                                    case 1:
                                      setState(() {
                                        _hasRegError = true;
                                        _regErrorText = 'Weak password';
                                        _sendingData = false;
                                      });
                                      break;
                                    case 2:
                                      setState(() {
                                        _hasRegError = true;
                                        _regErrorText = 'Email is in use';
                                        _sendingData = false;
                                      });
                                      break;
                                    case 3:
                                      setState(() {
                                        _hasRegError = true;
                                        _regErrorText = 'Invalid email';
                                        _sendingData = false;
                                      });
                                      break;
                                    default:
                                      setState(() {
                                        _hasRegError = true;
                                        _regErrorText = 'Something went wrong';
                                        _sendingData = false;
                                      });
                                      break;
                                  }
                                }
                              },
                            );
                          },
                          splashColor: Colors.blue.withOpacity(.6),
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Sign Up'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _sendingData ? const CircularProgressIndicator() : const Center(),
        ],
      ),
    );
  }

  Widget _authField(
    TextEditingController controller,
    String placeholderText,
    IconData leadingIcon, {
    bool? obscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).snackBarTheme.backgroundColor,
        border: Border(
          bottom: Theme.of(context).inputDecorationTheme.outlineBorder!,
          top: Theme.of(context).inputDecorationTheme.outlineBorder!,
          left: Theme.of(context).inputDecorationTheme.outlineBorder!,
          right: Theme.of(context).inputDecorationTheme.outlineBorder!,
        ),
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: obscure ?? false,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
          ),
          decoration: InputDecoration(
            border: Theme.of(context).inputDecorationTheme.border,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
            disabledBorder:
                Theme.of(context).inputDecorationTheme.disabledBorder,
            prefixIcon: Icon(
              leadingIcon,
              size: 25,
              color: Theme.of(context).inputDecorationTheme.prefixIconColor,
            ),
            hintText: placeholderText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordAuthField(
    TextEditingController controller,
    PasswordFormState passwordState,
    String placeholderText,
    IconData leadingIcon,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).snackBarTheme.backgroundColor,
        border: Border(
          bottom: Theme.of(context).inputDecorationTheme.outlineBorder!,
          top: Theme.of(context).inputDecorationTheme.outlineBorder!,
          left: Theme.of(context).inputDecorationTheme.outlineBorder!,
          right: Theme.of(context).inputDecorationTheme.outlineBorder!,
        ),
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          obscureText: (passwordState == PasswordFormState.login
              ? !_logPasswordVisible
              : !_regPasswordVisible),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
          ),
          decoration: InputDecoration(
            border: Theme.of(context).inputDecorationTheme.border,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
            disabledBorder:
                Theme.of(context).inputDecorationTheme.disabledBorder,
            prefixIcon: Icon(
              leadingIcon,
              size: 25,
              color: Theme.of(context).inputDecorationTheme.prefixIconColor,
            ),
            hintText: placeholderText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  if (passwordState == PasswordFormState.login) {
                    _logPasswordVisible = !_logPasswordVisible;
                  } else {
                    _regPasswordVisible = !_regPasswordVisible;
                  }
                });
              },
              icon: Icon(
                (passwordState == PasswordFormState.login
                        ? _logPasswordVisible
                        : _regPasswordVisible)
                    ? Icons.visibility
                    : Icons.visibility_off,
                size: 25,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayError(String errorText) {
    return FittedBox(
      child: Text(
        errorText,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 17,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
