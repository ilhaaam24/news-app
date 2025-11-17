import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/auth/domain/entities/user.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository authRepository;
  SignUp(this.authRepository);
  Future<Either<Failur, User>> execute(String email, String password) {
    return authRepository.signUp(email, password);
  }
}