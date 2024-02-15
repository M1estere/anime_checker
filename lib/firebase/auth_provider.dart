import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_checker/firebase/models/auth_user.dart';
import 'package:film_checker/firebase/models/user_full.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  Future<int> registerUser(
      String email, String password, String nickname) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.id).set(
          {
            'id': user.id,
            'email': user.email,
            'nickname': nickname,
            'reg_date': DateTime.now(),
          },
        );

        return 0;
      } else {
        return 4;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      } else if (e.code == 'invalid-email') {
        return 3;
      } else {
        return 4;
      }
    } catch (e) {
      return 4;
    }
  }

  Future<int> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = currentUser;
      if (user != null) {
        return 0;
      } else {
        return 4;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      } else if (e.code == 'invalid-email') {
        return 3;
      } else {
        return 4;
      }
    } catch (e) {
      return 3;
    }
  }

  Future<int> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
      return 0;
    } else {
      return 1;
    }
  }

  Future<UserFull> getFullUserInfo(String id) async {
    UserFull result;

    String nickname = '';
    String email = '';
    Timestamp regDate = Timestamp.fromDate(DateTime.now());
    String imagePath = '';
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();

    for (var element in snapshot.docs) {
      if (element.exists) {
        var data = element.data() as Map<String, dynamic>;
        if (data.containsKey('nickname')) {
          nickname = data['nickname'];
        }
        if (data.containsKey('email')) {
          email = data['email'];
        }
        if (data.containsKey('reg_date')) {
          regDate = data['reg_date'];
        }
        if (data.containsKey('image')) {
          imagePath = data['image'];
        }
      }
    }

    result = UserFull(
      id: id,
      email: email,
      nickname: nickname,
      registerDate: regDate,
      imagePath: imagePath,
    );

    return result;
  }

  bool userLogged() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
