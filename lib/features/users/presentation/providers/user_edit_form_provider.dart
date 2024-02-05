//StateNotifierProvider
import 'package:crud_firebase/features/shared/infrastructure/infrastructure.dart';
import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final userEditFormProvider =
    StateNotifierProvider<UserEditFormNotifier, UserEditFormState>((ref) {
  final getUsersCallback = ref.watch(userGetProvider.notifier).getUsers;
  final editUserCallback = ref.watch(userEditProvider.notifier).editUser;
  return UserEditFormNotifier(
    editUserCallback: editUserCallback,
    getUserAllCallback: getUsersCallback,
  );
});

//Notifier

class UserEditFormNotifier extends StateNotifier<UserEditFormState> {
  Function() getUserAllCallback;
  Future<void> Function(String, String, String, String) editUserCallback;
  UserEditFormNotifier({
    required this.getUserAllCallback,
    required this.editUserCallback,
  }) : super(UserEditFormState());

  void logout() {
    state = UserEditFormState(
      isPosting: false,
      isFormPosted: false,
      isValid: false,
      firstName: const Label.pure(),
      lastName: const Label.pure(),
      email: const Email.pure(),
    );
  }

  void initData(String firstName, String lastName, String email) {
    state = state.copyWith(
      firstName: Label.dirty(firstName),
      lastName: Label.dirty(lastName),
      email: Email.dirty(email),
      isValid: Formz.validate([
        Label.dirty(firstName),
        Label.dirty(lastName),
        Email.dirty(email),
      ]),
    );
  }

  onFirstNameChange(String value) {
    final newFirstName = Label.dirty(value);
    state = state.copyWith(
      firstName: newFirstName,
      isValid: Formz.validate([
        newFirstName,
        state.lastName,
        state.email,
      ]),
    );
  }

  onLastNameChange(String value) {
    final newLastName = Label.dirty(value);
    state = state.copyWith(
      lastName: newLastName,
      isValid: Formz.validate([
        state.firstName,
        newLastName,
        state.email,
      ]),
    );
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([
        state.firstName,
        state.lastName,
        newEmail,
      ]),
    );
  }

  onFormSubmit(String id) async {
    _touchEveryField();

    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);

    await editUserCallback(
      id,
      state.firstName.value,
      state.lastName.value,
      state.email.value,
    );
    await getUserAllCallback();

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final firsName = Label.dirty(state.firstName.value);
    final lastName = Label.dirty(state.lastName.value);
    final email = Email.dirty(state.email.value);

    state = state.copyWith(
      isFormPosted: true,
      firstName: firsName,
      lastName: lastName,
      email: email,
      isValid: Formz.validate([firsName, lastName, email]),
    );
  }
}

//State

class UserEditFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Label firstName;
  final Label lastName;
  final Email email;

  UserEditFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.firstName = const Label.pure(),
    this.lastName = const Label.pure(),
    this.email = const Email.pure(),
  });

  UserEditFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Label? firstName,
    Label? lastName,
    Email? email,
  }) =>
      UserEditFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
      );
}
