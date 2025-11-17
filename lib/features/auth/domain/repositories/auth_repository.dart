import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failur, User>> signIn(String email, String password);
  Future<Either<Failur, User>> signUp(String email, String password);
}