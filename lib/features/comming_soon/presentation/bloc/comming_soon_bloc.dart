import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/comming_soon/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_discovery_app/features/comming_soon/presentation/bloc/comming_soon_event.dart';
import 'package:movie_discovery_app/features/comming_soon/presentation/bloc/comming_soon_state.dart';

class ComingSoonBloc extends Bloc<ComingSoonEvent, ComingSoonState> {
  final GetUpcomingMovies getUpcomingMovies;

  int currentPage = 1;
  bool hasReachedEnd = false;
  bool isLoadingMore = false;

  ComingSoonBloc(this.getUpcomingMovies) : super(ComingSoonInitial()) {
    on<GetUpcomingMoviesEvent>(_getUpcomingMovies);
  }

  Future<void> _getUpcomingMovies(
    GetUpcomingMoviesEvent event,
    Emitter<ComingSoonState> emit,
  ) async {
    if (hasReachedEnd || isLoadingMore) {
      return;
    }

    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(ComingSoonLoading());
    } else {
      isLoadingMore = true;

      final currentState = state;

      if (currentState is ComingSoonLoaded) {
        emit(ComingSoonLoaded(currentState.movies, isLoadingMore: true));
      }
    }

    try {
      final movies = await getUpcomingMovies(event.page);

      if (movies.isEmpty) {
        hasReachedEnd = true;
        isLoadingMore = false;
        return;
      }

      currentPage = event.page;

      if (isFirstPage) {
        emit(ComingSoonLoaded(movies, isLoadingMore: false));
      } else {
        final currentState = state;

        if (currentState is ComingSoonLoaded) {
          emit(
            ComingSoonLoaded([
              ...currentState.movies,
              ...movies,
            ], isLoadingMore: false),
          );
        }
      }

      isLoadingMore = false;
    } catch (e) {
      isLoadingMore = false;

      emit(ComingSoonError(e.toString()));
    }
  }
}
