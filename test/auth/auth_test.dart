import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'auth_test.mocks.dart';

// Mock signIn result
class MockUserCredential extends Mock implements UserCredential {}

@GenerateMocks([FirebaseAuth, User])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late AuthRemoteDataSourceImpl datasource;
  late MockUser mockUser;
  late MockUserCredential mockCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    datasource = AuthRemoteDataSourceImpl(firebaseAuth: mockFirebaseAuth);
    mockUser = MockUser();
    mockCredential = MockUserCredential();
  });

  group("Sign In", () {
    test("Berhasil", () async {
      when(mockUser.email).thenReturn("test@example.com");
      when(mockCredential.user).thenReturn(mockUser);

      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
      ).thenAnswer((_) async => mockCredential);

      final result = await datasource.signIn("test@example.com", "password");

      expect(result, isA<User>());
      expect(result.email, "test@example.com");
    });

    test("Gagal", () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
      ).thenThrow(FirebaseAuthException(code: "wrong-password"));

      expect(() async {
        await datasource.signIn("test@example.com", "password");
      }, throwsA(isA<FirebaseAuthException>()));
    });
  });
  group("Sign Up", () {
    test("Berhasil", () async {
      when(mockUser.email).thenReturn("test@example.com");
      when(mockCredential.user).thenReturn(mockUser);

      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
      ).thenAnswer((_) async => mockCredential);

      final result = await datasource.signUp("test@example.com", "password");

      expect(result, isA<User>());
      expect(result.email, "test@example.com");
    });

    test("Gagal", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
      ).thenThrow(FirebaseAuthException(code: "wrong-password"));

      expect(() async {
        await datasource.signUp("test@example.com", "password");
      }, throwsA(isA<FirebaseAuthException>()));
    });
  });
}
