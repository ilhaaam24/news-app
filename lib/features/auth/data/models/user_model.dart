import 'package:news_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.uid, required super.email});

  factory UserModel.fromFirebaseUser(firebaseUser) {
    return UserModel(uid: firebaseUser.uid, email: firebaseUser.email!);
  }
}
