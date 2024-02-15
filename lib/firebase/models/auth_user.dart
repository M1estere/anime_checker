import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String id;
  final String email;

  const AuthUser({
    required this.id,
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        email: user.email!,
      );
}
