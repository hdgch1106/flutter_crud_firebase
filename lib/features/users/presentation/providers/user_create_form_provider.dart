//StateNotifierProvider
import 'package:crud_firebase/features/shared/infrastructure/infrastructure.dart';
import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final userCreateFormProvider =
    StateNotifierProvider<UserFormNotifier, UserFormState>((ref) {
  final getUsersCallback = ref.watch(userGetProvider.notifier).getUsers;
  final createUserCallback = ref.watch(userCreateProvider.notifier).createUser;
  //final editUserCallback = ref.watch(userEditProvider.notifier).editUser;
  return UserFormNotifier(
    //editUserCallback: editUserCallback,
    getUserAllCallback: getUsersCallback,
    createUserCallback: createUserCallback,
  );
});

//Notifier

class UserFormNotifier extends StateNotifier<UserFormState> {
  Function() getUserAllCallback;
  Future<void> Function(String, String, String) createUserCallback;
  UserFormNotifier({
    required this.getUserAllCallback,
    required this.createUserCallback,
  }) : super(UserFormState());

  void logout() {
    state = UserFormState(
      isPosting: false,
      isFormPosted: false,
      isValid: false,
      firstName: const Label.pure(),
      lastName: const Label.pure(),
      email: const Email.pure(),
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

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);

    await createUserCallback(
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

class UserFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Label firstName;
  final Label lastName;
  final Email email;

  UserFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.firstName = const Label.pure(),
    this.lastName = const Label.pure(),
    this.email = const Email.pure(),
  });

  UserFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Label? firstName,
    Label? lastName,
    Email? email,
  }) =>
      UserFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
      );
}
