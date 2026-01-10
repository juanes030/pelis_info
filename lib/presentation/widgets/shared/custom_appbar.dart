import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pelis_info/domain/entities/movie.dart';
import 'package:pelis_info/presentation/delegates/search_movie_delegate.dart';
import 'package:pelis_info/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary,),
              SizedBox(width: 5),
              Text('PelisInfo', style: titleStyle),
              Spacer(),
              IconButton(
                onPressed: (){
                  final searchMovies = ref.read(searchMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchMovieDelegate(
                      initialMovies: searchMovies,
                      searchMovies: ref.read(searchMoviesProvider.notifier).searchMoviesByQuery
                    )
                  ).then((movie) {
                    if(movie == null) return;
                    if (!context.mounted) return;
                    context.push('/movie/${movie.id}');
                  });
                }, 
                icon: Icon(Icons.search)
              )
            ],
          ),
        ),
      ),
    );
  }

}