import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:news_app/features/auth/data/models/user_model.dart';
import 'package:news_app/features/auth/domain/entities/user.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDatasource remote;
  AuthRepositoryImpl({required this.remote});
  @override
  Future<Either<Failur, User>> signIn(String email, String password) async {
    try {
      var result = await remote.signIn(email, password);

      return Right(UserModel.fromFirebaseUser(result));
    } catch (e) {
      return Left(Failur());
    }
  }

  @override
  Future<Either<Failur, User>> signUp(String email, String password) async {
    try {
      var result = await remote.signUp(email, password);
      return Right(UserModel.fromFirebaseUser(result));
    } catch (e) {
      return Left(Failur());
    }
  }
}
