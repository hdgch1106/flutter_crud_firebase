import 'package:crud_firebase/features/shared/infrastructure/infrastructure.dart';
import 'package:crud_firebase/features/users/infrastructure/infrastructure.dart';
import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_create_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepositoryImpl>()])
void main() {
  // Create a mock instance of UserRepositoryImpl
  final mockUserRepository = MockUserRepositoryImpl();

  final userCreateNotifier = UserCreateNotifier(
    userRepository: mockUserRepository,
  );

  group("UserCreateProvider", () {
    // Test createUser
    test("should return a string when creating user", () async {
      when(mockUserRepository.createUser(
        "Hugo",
        "Grados",
        "hdgch1106@gmail.com",
      )).thenAnswer((_) async {});

      await userCreateNotifier.createUser(
        "Hugo",
        "Grados",
        "hdgch1106@gmail.com",
      );

      verify(mockUserRepository.createUser(
        "Hugo",
        "Grados",
        "hdgch1106@gmail.com",
      )).called(1);
    });

    test("isLoading should be false before calling createUser and false after",
        () async {
      when(mockUserRepository.createUser(
        "Hugo",
        "Grados",
        "hdgch1106@gmail.com",
      )).thenAnswer((_) async {});

      expect(userCreateNotifier.state.isLoading, isFalse);

      await userCreateNotifier.createUser(
        "Hugo",
        "Grados",
        "hdgch1106@gmail.com",
      );

      expect(userCreateNotifier.state.isLoading, isFalse);
    });

    test("should handle CustomError correctly", () async {
      final customError = CustomError(message: "Error de prueba");

      when(mockUserRepository.createUser(
        "Hugo",
        "Grados",
        "hdgch1106@gmail.com",
      )).thenThrow(customError);

      await userCreateNotifier.createUser(
        "Hugo",
        "Grados",
        "hdgch1106@gmail.com",
      );

      expect(userCreateNotifier.state.error.message, "");
      expect(userCreateNotifier.state.isLoading, isFalse);
    });
  });
}
