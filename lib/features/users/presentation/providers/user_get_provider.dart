import 'package:crud_firebase/features/shared/infrastructure/errors/custom_error.dart';
import 'package:crud_firebase/features/users/domain/domain.dart';
import 'package:crud_firebase/features/users/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userGetProvider =
    StateNotifierProvider<UserGetNotifier, UserGetState>((ref) {
  final userRepository = UserRepositoryImpl();

  return UserGetNotifier(
    userRepository: userRepository,
  );
});

class UserGetNotifier extends StateNotifier<UserGetState> {
  final UserRepository userRepository;

  UserGetNotifier({
    required this.userRepository,
  }) : super(UserGetState());

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

  Future<void> getUsers() async {
    try {
      state = state.copyWith(isLoading: true);
      //Realiza la petición
      final users = await userRepository.getUsers();
      state = state.copyWith(
        users: users,
        response: "Users obtained successfully",
        isLoading: false,
      );
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
    state = UserGetState(
      error: CustomError(message: ""),
      isLoading: false,
    );
  }
}

//Estado

class UserGetState {
  final List<UserEntity>? users;
  final String response;
  final CustomError error;
  final bool isLoading;

  UserGetState({
    this.users,
    this.response = "",
    CustomError? error,
    this.isLoading = false,
  }) : error = error ?? CustomError(message: "", notFoundToken: false);

  UserGetState copyWith({
    List<UserEntity>? users,
    String? response,
    CustomError? error,
    bool? isLoading,
  }) =>
      UserGetState(
        users: users ?? this.users,
        response: response ?? this.response,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
      );
}
