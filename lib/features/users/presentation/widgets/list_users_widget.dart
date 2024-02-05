import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets.dart';

class ListUsersWidgets extends ConsumerWidget {
  const ListUsersWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userGetState = ref.watch(userGetProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: userGetState.users!.length,
            itemBuilder: (context, index) {
              final user = userGetState.users![index];
              return UserTile(user: user);
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ],
    );
  }
}
