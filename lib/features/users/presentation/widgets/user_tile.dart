import 'package:crud_firebase/config/helper/helper.dart';
import 'package:crud_firebase/config/theme/theme.dart';
import 'package:crud_firebase/features/users/domain/domain.dart';
import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserTile extends ConsumerWidget {
  final UserEntity user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _buildImage(size),
          const SizedBox(width: 10),
          _buildTitleAndSubTitle(size),
          const Spacer(),
          _buildActions(context, ref),
        ],
      ),
    );
  }

  Row _buildActions(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            ref.read(userEditFormProvider.notifier).initData(
                  user.firstName,
                  user.lastName,
                  user.email,
                );
            context.push("/edit", extra: user.id);
          },
          icon: const Icon(
            Icons.edit_outlined,
            color: Colors.black54,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: () {
            CustomDialogs().showAlert(
              context: context,
              title: "Alerta",
              subtitle: "¿Estás seguro que deseas eliminar este usuario?",
              actions: [
                TextButton(
                  onPressed: () {
                    ref.read(userDeleteProvider.notifier).deleteUser(user.id);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text("Eliminar"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text("Cerrar"),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  SizedBox _buildTitleAndSubTitle(Size size) {
    return SizedBox(
      width: size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${user.firstName} ${user.lastName}",
            style: subtitleStyle(),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            user.email,
            style: litletitleStyle(),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Container _buildImage(Size size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
      ),
      child: Image.asset(
        "assets/images/employee.png",
        height: size.height * 0.065,
      ),
    );
  }
}
