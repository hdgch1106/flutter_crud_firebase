import 'package:crud_firebase/features/users/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const UsersScreen(),
    ),
    GoRoute(
      path: "/create",
      builder: (context, state) => const UsersCreateScreen(),
    ),
    GoRoute(
      path: "/edit",
      builder: (context, state) {
        String id = state.extra as String;
        return UsersEditScreen(id: id);
      },
    )
  ],
);
