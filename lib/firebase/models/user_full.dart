import 'package:cloud_firestore/cloud_firestore.dart';

class UserFull {
  final String id;
  final String email;
  final String nickname;
  final Timestamp registerDate;
  final String imagePath;

  const UserFull({
    required this.id,
    required this.email,
    required this.nickname,
    required this.registerDate,
    required this.imagePath,
  });
}
