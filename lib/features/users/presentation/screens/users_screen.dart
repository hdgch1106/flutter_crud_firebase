import 'package:crud_firebase/config/helper/helper.dart';
import 'package:crud_firebase/features/shared/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crud_firebase/config/theme/theme.dart';
import 'package:crud_firebase/features/users/presentation/providers/providers.dart';
import 'package:crud_firebase/features/users/presentation/widgets/widgets.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  UsersScreenState createState() => UsersScreenState();
}

class UsersScreenState extends ConsumerState<UsersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userGetProvider.notifier).getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    listenToUserDelete();
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(size),
          _buildHeader(),
          const _BodyUsersScreen(),
        ],
      ),
    );
  }

  Positioned _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(
              "Crud de Usuarios",
              style: titleStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBackground(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: ColorsCustom.greenLight,
    );
  }

  void listenToUserDelete() {
    ref.listen(userDeleteProvider.select((value) => value.error.message),
        (previous, next) {
      if (next.isEmpty) return;
      CustomDialogs().showAlert(
        context: context,
        title: "Error",
        subtitle: next,
      );
    });

    ref.listen(userDeleteProvider.select((value) => value.response),
        (previous, next) {
      if (next.isEmpty) return;
      CustomDialogs().showAlert(
        context: context,
        title: "Información",
        subtitle: next,
      );
    });
  }
}

class _BodyUsersScreen extends ConsumerWidget {
  const _BodyUsersScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final userGetState = ref.watch(userGetProvider);

    List<BoxShadow>? boxShadow = [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        spreadRadius: 1,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ];
    return Column(
      children: [
        SizedBox(height: size.height * 0.17),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsCustom.background,
              boxShadow: boxShadow,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                FilledButton(
                  child: Text(
                    "Crear usuario",
                    style: subtitleStyle().copyWith(color: Colors.white),
                  ),
                  onPressed: () => context.push("/create"),
                ),
                _buildBody(userGetState, ref),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(
    UserGetState userGetState,
    WidgetRef ref,
  ) {
    if (userGetState.isLoading) {
      // Si los usuarios están cargando, muestra un indicador de progreso
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    } else if (userGetState.error.message.isNotEmpty) {
      // Si hay un error al obtener los usuarios, muestra un widget de reintentar
      return RetryWidget(
        errorMessage: userGetState.error.message,
        onPressed: () => ref.read(userGetProvider.notifier).getUsers(),
      );
    } else if (userGetState.users != null && userGetState.users!.isNotEmpty) {
      // Si hay usuarios para mostrar, muestra la lista de usuarios
      return const Expanded(child: ListUsersWidgets());
    } else {
      // Si no hay usuarios para mostrar, muestra un mensaje
      return Expanded(
        child: Center(
          child: Text(
            "No hay usuarios para mostrar",
            style: subtitleStyle(),
          ),
        ),
      );
    }
  }
}
