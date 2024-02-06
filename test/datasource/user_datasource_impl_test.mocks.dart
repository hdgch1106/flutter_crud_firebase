// Mocks generated by Mockito 5.4.4 from annotations
// in crud_firebase/test/datasource/user_datasource_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:crud_firebase/features/users/domain/domain.dart' as _i5;
import 'package:crud_firebase/features/users/infrastructure/datasources/user_datasource_impl.dart'
    as _i3;
import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserDatasourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserDatasourceImpl extends _i1.Mock
    implements _i3.UserDatasourceImpl {
  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
        returnValueForMissingStub: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);

  @override
  _i4.Future<void> createUser(
    String? firstName,
    String? lastName,
    String? email,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUser,
          [
            firstName,
            lastName,
            email,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> deleteUser(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> editUser(
    String? id,
    String? firstName,
    String? lastName,
    String? email,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #editUser,
          [
            id,
            firstName,
            lastName,
            email,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i5.UserEntity>> getUsers() => (super.noSuchMethod(
        Invocation.method(
          #getUsers,
          [],
        ),
        returnValue: _i4.Future<List<_i5.UserEntity>>.value(<_i5.UserEntity>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i5.UserEntity>>.value(<_i5.UserEntity>[]),
      ) as _i4.Future<List<_i5.UserEntity>>);
}
