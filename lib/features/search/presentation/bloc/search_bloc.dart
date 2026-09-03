import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/search/domain/usecase/search_movies.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc(this.searchMovies) : super(SearchInitial()) {
    on<SearchMovieEvent>(_searchMovies);
  }

  Future<void> _searchMovies(
    SearchMovieEvent event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final movies = await searchMovies(query);

      if (movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(movies));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}