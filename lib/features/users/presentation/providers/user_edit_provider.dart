import 'package:crud_firebase/features/shared/infrastructure/errors/custom_error.dart';
import 'package:crud_firebase/features/users/domain/domain.dart';
import 'package:crud_firebase/features/users/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

final userEditProvider =
    StateNotifierProvider<UserEditNotifier, UserEditState>((ref) {
  final getUsersCallback = ref.watch(userGetProvider.notifier).getUsers;
  final userRepository = UserRepositoryImpl();

  return UserEditNotifier(
    getUserAllCallback: getUsersCallback,
    userRepository: userRepository,
  );
});

class UserEditNotifier extends StateNotifier<UserEditState> {
  Function() getUserAllCallback;
  final UserRepository userRepository;

  UserEditNotifier({
    required this.getUserAllCallback,
    required this.userRepository,
  }) : super(UserEditState());

  void resetResponse() {
    state = state.copyWith(
      response: "",
    );
  }

  void resetErrorResponse() {
    state = state.copyWith(
      error: CustomError(message: ""),
    );
  }

  Future<void> editUser(
    String id,
    String firstName,
    String lastName,
    String email,
  ) async {
    try {
      state = state.copyWith(isLoading: true);
      //Realiza la petición
      await userRepository.editUser(
        id,
        firstName,
        lastName,
        email,
      );
      state = state.copyWith(
        response: "Usuario editado correctamente",
        isLoading: false,
      );
      getUserAllCallback();
      resetResponse();
    } on CustomError catch (e) {
      _handleCustomError(e);
    } catch (e) {
      _handleGenericError();
    }
  }

  void _handleCustomError(CustomError error) {
    state = state.copyWith(
      error: error,
      isLoading: false,
    );
    resetErrorResponse();
  }

  void _handleGenericError() {
    state = state.copyWith(
      error: CustomError(message: "Error no controlado"),
      isLoading: false,
    );
    resetErrorResponse();
  }

  void logout() {
    state = UserEditState(
      error: CustomError(message: ""),
      isLoading: false,
    );
  }
}

//Estado

class UserEditState {
  final String response;
  final CustomError error;
  final bool isLoading;

  UserEditState({
    this.response = "",
    CustomError? error,
    this.isLoading = false,
  }) : error = error ?? CustomError(message: "", notFoundToken: false);

  UserEditState copyWith({
    String? response,
    CustomError? error,
    bool? isLoading,
  }) =>
      UserEditState(
        response: response ?? this.response,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
      );
}
