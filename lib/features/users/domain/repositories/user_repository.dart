import 'package:crud_firebase/features/users/domain/domain.dart';

abstract class UserRepository {
  Future<void> createUser(
    String firstName,
    String lastName,
    String email,
  );
  Future<void> editUser(
    String id,
    String firstName,
    String lastName,
    String email,
  );
  Future<void> deleteUser(String id);
  Future<List<UserEntity>> getUsers();
}
