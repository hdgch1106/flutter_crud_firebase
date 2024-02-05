import 'package:crud_firebase/features/shared/infrastructure/errors/custom_error.dart';
import 'package:crud_firebase/features/users/domain/domain.dart';
import 'package:crud_firebase/features/users/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

final userDeleteProvider =
    StateNotifierProvider<UserDeleteNotifier, UserDeleteState>((ref) {
  final getUsersCallback = ref.watch(userGetProvider.notifier).getUsers;
  final userRepository = UserRepositoryImpl();

  return UserDeleteNotifier(
    getUserAllCallback: getUsersCallback,
    userRepository: userRepository,
  );
});

class UserDeleteNotifier extends StateNotifier<UserDeleteState> {
  Function() getUserAllCallback;
  final UserRepository userRepository;

  UserDeleteNotifier({
    required this.getUserAllCallback,
    required this.userRepository,
  }) : super(UserDeleteState());

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

  Future<void> deleteUser(String id) async {
    try {
      state = state.copyWith(isLoading: true);
      //Realiza la petición
      await userRepository.deleteUser(id);
      state = state.copyWith(
        response: "Usuario eliminado correctamente",
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
    state = UserDeleteState(
      error: CustomError(message: ""),
      isLoading: false,
    );
  }
}

//Estado

class UserDeleteState {
  final String response;
  final CustomError error;
  final bool isLoading;

  UserDeleteState({
    this.response = "",
    CustomError? error,
    this.isLoading = false,
  }) : error = error ?? CustomError(message: "", notFoundToken: false);

  UserDeleteState copyWith({
    String? response,
    CustomError? error,
    bool? isLoading,
  }) =>
      UserDeleteState(
        response: response ?? this.response,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
      );
}
