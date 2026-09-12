import 'package:go_router/go_router.dart';
import 'package:pelis_info/features/explore/presentation/views/explore_view.dart';
import 'package:pelis_info/features/favorites/presentation/views/favorites_view.dart';
import 'package:pelis_info/features/home/presentation/views/home_view.dart';
import 'package:pelis_info/features/movie_detail/presentation/screens/movie_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/explore',
      builder: (context, state) => const ExploreView(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesView(),
    ),
  ],
);