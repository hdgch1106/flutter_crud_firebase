import 'package:crud_firebase/features/users/domain/domain.dart';
import 'package:crud_firebase/features/users/infrastructure/infrastructure.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl({UserDatasource? datasource})
      : datasource = datasource ?? UserDatasourceImpl();

  @override
  Future<void> createUser(String firstName, String lastName, String email) {
    return datasource.createUser(firstName, lastName, email);
  }

  @override
  Future<void> deleteUser(String id) {
    return datasource.deleteUser(id);
  }

  @override
  Future<void> editUser(
      String id, String firstName, String lastName, String email) {
    return datasource.editUser(id, firstName, lastName, email);
  }

  @override
  Future<List<UserEntity>> getUsers() {
    return datasource.getUsers();
  }
}
