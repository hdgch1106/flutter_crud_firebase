import 'package:crud_firebase/config/helper/helper.dart';
import 'package:crud_firebase/config/theme/theme.dart';
import 'package:crud_firebase/features/shared/presentation/widgets/widgets.dart';
import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersCreateScreen extends StatelessWidget {
  const UsersCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Crear Usuario"),
      ),
      body: const _UsersCreateForm(),
    );
  }
}

class _UsersCreateForm extends ConsumerWidget {
  const _UsersCreateForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCreateForm = ref.watch(userCreateFormProvider);

    listenToUserCreate(context, ref);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nombre:", style: subtitleStyle()),
          const SizedBox(height: 10),
          CustomTextFormField(
            onChanged: (value) => ref
                .read(userCreateFormProvider.notifier)
                .onFirstNameChange(value),
            errorMessage: userCreateForm.isFormPosted
                ? userCreateForm.firstName.errorMessage
                : null,
          ),
          const SizedBox(height: 20),
          Text("Apellido:", style: subtitleStyle()),
          const SizedBox(height: 10),
          CustomTextFormField(
            onChanged: (value) => ref
                .read(userCreateFormProvider.notifier)
                .onLastNameChange(value),
            errorMessage: userCreateForm.isFormPosted
                ? userCreateForm.lastName.errorMessage
                : null,
          ),
          const SizedBox(height: 20),
          Text("Email:", style: subtitleStyle()),
          const SizedBox(height: 10),
          CustomTextFormField(
            onChanged: (value) =>
                ref.read(userCreateFormProvider.notifier).onEmailChange(value),
            errorMessage: userCreateForm.isFormPosted
                ? userCreateForm.email.errorMessage
                : null,
          ),
          Expanded(child: Container()),
          userCreateForm.isPosting
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : _buildActions(ref),
        ],
      ),
    );
  }

  void listenToUserCreate(BuildContext context, WidgetRef ref) {
    ref.listen(userCreateProvider.select((value) => value.response),
        (previous, next) {
      if (next.isEmpty) return;
      CustomDialogs().showAlert(
        context: context,
        title: "Información",
        subtitle: next,
      );
    });

    ref.listen(userCreateProvider.select((value) => value.error.message),
        (previous, next) {
      if (next.isEmpty) return;
      CustomDialogs().showAlert(
        context: context,
        title: "Error",
        subtitle: next,
      );
    });
  }

  Center _buildActions(WidgetRef ref) {
    return Center(
      child: FilledButton(
        child: Text(
          "Crear",
          style: subtitleStyle().copyWith(color: Colors.white),
        ),
        onPressed: () =>
            ref.read(userCreateFormProvider.notifier).onFormSubmit(),
      ),
    );
  }
}
