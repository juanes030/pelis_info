import 'package:go_router/go_router.dart';
import 'package:pelis_info/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    )
  ]
);