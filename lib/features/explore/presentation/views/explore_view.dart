import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/core/widgets/widgets.dart';
import 'package:pelis_info/features/explore/domain/entities/movie_genre.dart';
import 'package:pelis_info/features/explore/presentation/providers/explore_provider.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  @override
  void initState() {
    super.initState();
    ref.read(exploreGenresProvider.notifier).loadGenres();
  }

  @override
  Widget build(BuildContext context) {
    final genres = ref.watch(exploreGenresProvider);
    final genresNotifier = ref.read(exploreGenresProvider.notifier);
    final movies = ref.watch(exploreMoviesProvider);
    final moviesNotifier = ref.read(exploreMoviesProvider.notifier);
    final selectedGenreId = moviesNotifier.selectedGenreId;
    final matchingGenres = genres.where((genre) => genre.id == selectedGenreId);
    final selectedGenre = matchingGenres.isEmpty ? null : matchingGenres.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedGenre == null ? 'Explorar' : selectedGenre.name),
        leading: selectedGenre == null
            ? null
            : IconButton(
                onPressed: () {
                  moviesNotifier.clearSelection();
                },
                icon: const Icon(Icons.arrow_back),
              ),
      ),
      body: selectedGenre == null
          ? _GenreSelector(
              genres: genres,
              errorMessage: genresNotifier.errorMessage,
              isLoading: genres.isEmpty && genresNotifier.errorMessage == null,
              onRetry: () => genresNotifier.loadGenres(),
              onGenreSelected: (genreId) {
                moviesNotifier.selectGenre(genreId);
              },
            )
          : _MoviesByGenre(
              movies: movies,
              errorMessage: moviesNotifier.errorMessage,
              isLoading: movies.isEmpty && moviesNotifier.isLoading,
              onRetry: () => moviesNotifier.loadNextPage(),
              loadNextPage: () => moviesNotifier.loadNextPage(),
            ),
      bottomNavigationBar: const CustomBottonNavigationbar(),
    );
  }
}

class _GenreSelector extends StatelessWidget {
  const _GenreSelector({
    required this.genres,
    required this.errorMessage,
    required this.isLoading,
    required this.onRetry,
    required this.onGenreSelected,
  });

  final List<MovieGenre> genres;
  final String? errorMessage;
  final bool isLoading;
  final VoidCallback onRetry;
  final ValueChanged<int> onGenreSelected;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const FullScreenLoader();

    if (errorMessage != null) {
      return _ExploreMessage(
        icon: Icons.cloud_off_outlined,
        message: errorMessage!,
        actionLabel: 'Reintentar',
        onAction: onRetry,
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        Text(
          'Encuentra películas por género',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text('Elige un género para descubrir nuevas películas.'),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: genres.map((genre) {
            return ActionChip(
              avatar: const Icon(Icons.movie_filter_outlined, size: 18),
              label: Text(genre.name),
              onPressed: () => onGenreSelected(genre.id),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MoviesByGenre extends StatelessWidget {
  const _MoviesByGenre({
    required this.movies,
    required this.errorMessage,
    required this.isLoading,
    required this.onRetry,
    required this.loadNextPage,
  });

  final List<Movie> movies;
  final String? errorMessage;
  final bool isLoading;
  final VoidCallback onRetry;
  final Future<List<Movie>> Function() loadNextPage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const FullScreenLoader();

    if (errorMessage != null && movies.isEmpty) {
      return _ExploreMessage(
        icon: Icons.cloud_off_outlined,
        message: errorMessage!,
        actionLabel: 'Reintentar',
        onAction: onRetry,
      );
    }

    if (movies.isEmpty) {
      return const _ExploreMessage(
        icon: Icons.movie_outlined,
        message: 'No encontramos películas para este género.',
      );
    }

    return MovieMasonry(
      movies: movies,
      loadNextPage: loadNextPage,
    );
  }
}

class _ExploreMessage extends StatelessWidget {
  const _ExploreMessage({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            if (actionLabel != null) ...[
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
