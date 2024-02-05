import 'package:crud_firebase/config/theme/theme.dart';
import 'package:crud_firebase/features/shared/presentation/widgets/widgets.dart';
import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/helper/helper.dart';

class UsersEditScreen extends StatelessWidget {
  final String id;
  const UsersEditScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Usuario"),
      ),
      body: _UsersEditForm(id: id),
    );
  }
}

class _UsersEditForm extends ConsumerWidget {
  final String id;
  const _UsersEditForm({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEditForm = ref.watch(userEditFormProvider);
    listenToEditCreate(context, ref);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nombre:", style: subtitleStyle()),
          const SizedBox(height: 10),
          CustomTextFormField(
            initialValue: userEditForm.firstName.value,
            onChanged: (value) => ref
                .read(userEditFormProvider.notifier)
                .onFirstNameChange(value),
            errorMessage: userEditForm.isFormPosted
                ? userEditForm.firstName.errorMessage
                : null,
          ),
          const SizedBox(height: 20),
          Text("Apellido:", style: subtitleStyle()),
          const SizedBox(height: 10),
          CustomTextFormField(
            initialValue: userEditForm.lastName.value,
            onChanged: (value) =>
                ref.read(userEditFormProvider.notifier).onLastNameChange(value),
            errorMessage: userEditForm.isFormPosted
                ? userEditForm.lastName.errorMessage
                : null,
          ),
          const SizedBox(height: 20),
          Text("Email:", style: subtitleStyle()),
          const SizedBox(height: 10),
          CustomTextFormField(
            initialValue: userEditForm.email.value,
            onChanged: (value) =>
                ref.read(userEditFormProvider.notifier).onEmailChange(value),
            errorMessage: userEditForm.isFormPosted
                ? userEditForm.email.errorMessage
                : null,
          ),
          Expanded(child: Container()),
          userEditForm.isPosting
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : _buildActions(ref, id),
        ],
      ),
    );
  }

  Center _buildActions(WidgetRef ref, String id) {
    return Center(
      child: FilledButton(
        child: Text(
          "Editar",
          style: subtitleStyle().copyWith(color: Colors.white),
        ),
        onPressed: () =>
            ref.read(userEditFormProvider.notifier).onFormSubmit(id),
      ),
    );
  }

  void listenToEditCreate(BuildContext context, WidgetRef ref) {
    ref.listen(userEditProvider.select((value) => value.response),
        (previous, next) {
      if (next.isEmpty) return;
      CustomDialogs().showAlert(
        context: context,
        title: "Información",
        subtitle: next,
      );
    });

    ref.listen(userEditProvider.select((value) => value.error.message),
        (previous, next) {
      if (next.isEmpty) return;
      CustomDialogs().showAlert(
        context: context,
        title: "Error",
        subtitle: next,
      );
    });
  }
}
