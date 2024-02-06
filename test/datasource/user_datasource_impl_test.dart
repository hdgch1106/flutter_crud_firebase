import 'package:crud_firebase/features/users/domain/domain.dart';
import 'package:crud_firebase/features/users/infrastructure/datasources/user_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserDatasourceImpl>()])
void main() {
  late MockUserDatasourceImpl datasource;
  setUp(() {
    datasource = MockUserDatasourceImpl();
  });
  group("UserDataSourceImpl", () {
    // Test getUsers
    test("should return a list of UserEntity", () async {
      when(datasource.getUsers()).thenAnswer((realInvocation) async {
        return [
          UserEntity(
            id: "1",
            firstName: "Hugo",
            lastName: "Grados",
            email: "test@gmail.com",
          ),
          UserEntity(
            id: "2",
            firstName: "David",
            lastName: "Martinez",
            email: "test2@gmail.com",
          )
        ];
      });

      final result = await datasource.getUsers();

      expect(result, isA<List<UserEntity>>());
      expect(result.first.firstName, "Hugo");
      expect(result.length, 2);
    });

    // Test createUser
    test(
      "should call createUser with correct arguments",
      () async {
        await datasource.createUser("Hugo", "Grados", "test@gmail.com");

        verify(datasource.createUser("Hugo", "Grados", "test@gmail.com"))
            .called(1);
      },
    );

    // Test editUser
    test(
      "should call editUser with correct arguments",
      () async {
        await datasource.editUser("1", "Hugo", "Grados", "test@gmail.com");

        verify(datasource.editUser("1", "Hugo", "Grados", "test@gmail.com"))
            .called(1);
      },
    );
  });
}
