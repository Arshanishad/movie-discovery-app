import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_top_rated.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_trending_movies.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPopularMovies getPopularMovies;
  final GetTrendingMovies getTrendingMovies;
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetTopRatedMovies getTopRatedMovies;



  int popularPage = 1;
  int trendingPage = 1;
  int nowPlayingPage = 1;
  int topRatedPage = 1;



  bool isPopularLoadingMore = false;
  bool isTrendingLoadingMore = false;
  bool isNowPlayingLoadingMore = false;
  bool isTopRatedLoadingMore = false;

  bool popularHasReachedEnd = false;
  bool trendingHasReachedEnd = false;
  bool nowPlayingHasReachedEnd = false;
  bool topRatedHasReachedEnd = false;

  HomeBloc(
    this.getPopularMovies,
    this.getTrendingMovies,
    this.getNowPlayingMovies,
    this.getTopRatedMovies,
  ) : super(HomeInitial()) {
    on<GetHomeMoviesEvent>(_getHomeMovies);

    on<LoadMorePopularMoviesEvent>(
      _loadMorePopularMovies,
    );

    on<LoadMoreTrendingMoviesEvent>(
      _loadMoreTrendingMovies,
    );

    on<LoadMoreNowPlayingMoviesEvent>(
      _loadMoreNowPlayingMovies,
    );

    on<LoadMoreTopRatedMoviesEvent>(
      _loadMoreTopRatedMovies,
    );
  }


  Future<void> _getHomeMovies(
  GetHomeMoviesEvent event,
  Emitter<HomeState> emit,
) async {
  popularPage = 1;
  trendingPage = 1;
  nowPlayingPage = 1;
  topRatedPage = 1;

  popularHasReachedEnd = false;
  trendingHasReachedEnd = false;
  nowPlayingHasReachedEnd = false;
  topRatedHasReachedEnd = false;

  isPopularLoadingMore = false;
  isTrendingLoadingMore = false;
  isNowPlayingLoadingMore = false;
  isTopRatedLoadingMore = false;

  emit(HomeLoading());

  try {
    final popularMovies = await getPopularMovies(1);

    final trendingMovies = await getTrendingMovies(1);

    final nowPlayingMovies = await getNowPlayingMovies(1);

    final topRatedMovies = await getTopRatedMovies(1);

    emit(
      HomeLoaded(
        popularMovies: popularMovies,
        trendingMovies: trendingMovies,
        nowPlayingMovies: nowPlayingMovies,
        topRatedMovies: topRatedMovies,
      ),
    );
  } catch (e) {
    emit(
      HomeError(
        e.toString(),
      ),
    );
  }
}

  Future<void> _loadMorePopularMovies(
    LoadMorePopularMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (isPopularLoadingMore ||
        popularHasReachedEnd) {
      return;
    }

    final currentState = state;

    if (currentState is! HomeLoaded) {
      return;
    }

    isPopularLoadingMore = true;

    emit(
      HomeLoaded(
        popularMovies: currentState.popularMovies,
        trendingMovies: currentState.trendingMovies,
        nowPlayingMovies: currentState.nowPlayingMovies,
        topRatedMovies: currentState.topRatedMovies,
        isPopularLoadingMore: true,
        isTrendingLoadingMore:
            currentState.isTrendingLoadingMore,
        isNowPlayingLoadingMore:
            currentState.isNowPlayingLoadingMore,
        isTopRatedLoadingMore:
            currentState.isTopRatedLoadingMore,
      ),
    );

    try {
      final nextPage = popularPage + 1;

      final movies = await getPopularMovies(
        nextPage,
      );

      if (movies.isEmpty) {
        popularHasReachedEnd = true;
      } else {
        popularPage = nextPage;

        emit(
          HomeLoaded(
            popularMovies: [
              ...currentState.popularMovies,
              ...movies,
            ],
            trendingMovies: currentState.trendingMovies,
            nowPlayingMovies: currentState.nowPlayingMovies,
            topRatedMovies: currentState.topRatedMovies,
            isPopularLoadingMore: false,
            isTrendingLoadingMore:
                currentState.isTrendingLoadingMore,
            isNowPlayingLoadingMore:
                currentState.isNowPlayingLoadingMore,
            isTopRatedLoadingMore:
                currentState.isTopRatedLoadingMore,
          ),
        );
      }
    } catch (e) {
    }

    isPopularLoadingMore = false;

    final latestState = state;

    if (latestState is HomeLoaded) {
      emit(
        HomeLoaded(
          popularMovies: latestState.popularMovies,
          trendingMovies: latestState.trendingMovies,
          nowPlayingMovies: latestState.nowPlayingMovies,
          topRatedMovies: latestState.topRatedMovies,
          isPopularLoadingMore: false,
          isTrendingLoadingMore:
              latestState.isTrendingLoadingMore,
          isNowPlayingLoadingMore:
              latestState.isNowPlayingLoadingMore,
          isTopRatedLoadingMore:
              latestState.isTopRatedLoadingMore,
        ),
      );
    }
  }


  Future<void> _loadMoreTrendingMovies(
    LoadMoreTrendingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (isTrendingLoadingMore ||
        trendingHasReachedEnd) {
      return;
    }

    final currentState = state;

    if (currentState is! HomeLoaded) {
      return;
    }

    isTrendingLoadingMore = true;

    emit(
      HomeLoaded(
        popularMovies: currentState.popularMovies,
        trendingMovies: currentState.trendingMovies,
        nowPlayingMovies: currentState.nowPlayingMovies,
        topRatedMovies: currentState.topRatedMovies,
        isPopularLoadingMore:
            currentState.isPopularLoadingMore,
        isTrendingLoadingMore: true,
        isNowPlayingLoadingMore:
            currentState.isNowPlayingLoadingMore,
        isTopRatedLoadingMore:
            currentState.isTopRatedLoadingMore,
      ),
    );

    try {
      final nextPage = trendingPage + 1;

      final movies = await getTrendingMovies(
        nextPage,
      );

      if (movies.isEmpty) {
        trendingHasReachedEnd = true;
      } else {
        trendingPage = nextPage;

        emit(
          HomeLoaded(
            popularMovies: currentState.popularMovies,
            trendingMovies: [
              ...currentState.trendingMovies,
              ...movies,
            ],
            nowPlayingMovies: currentState.nowPlayingMovies,
            topRatedMovies: currentState.topRatedMovies,
            isPopularLoadingMore:
                currentState.isPopularLoadingMore,
            isTrendingLoadingMore: false,
            isNowPlayingLoadingMore:
                currentState.isNowPlayingLoadingMore,
            isTopRatedLoadingMore:
                currentState.isTopRatedLoadingMore,
          ),
        );
      }
    } catch (e) {
    }

    isTrendingLoadingMore = false;

    final latestState = state;

    if (latestState is HomeLoaded) {
      emit(
        HomeLoaded(
          popularMovies: latestState.popularMovies,
          trendingMovies: latestState.trendingMovies,
          nowPlayingMovies: latestState.nowPlayingMovies,
          topRatedMovies: latestState.topRatedMovies,
          isPopularLoadingMore:
              latestState.isPopularLoadingMore,
          isTrendingLoadingMore: false,
          isNowPlayingLoadingMore:
              latestState.isNowPlayingLoadingMore,
          isTopRatedLoadingMore:
              latestState.isTopRatedLoadingMore,
        ),
      );
    }
  }



  Future<void> _loadMoreNowPlayingMovies(
    LoadMoreNowPlayingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (isNowPlayingLoadingMore ||
        nowPlayingHasReachedEnd) {
      return;
    }

    final currentState = state;

    if (currentState is! HomeLoaded) {
      return;
    }

    isNowPlayingLoadingMore = true;

    emit(
      HomeLoaded(
        popularMovies: currentState.popularMovies,
        trendingMovies: currentState.trendingMovies,
        nowPlayingMovies: currentState.nowPlayingMovies,
        topRatedMovies: currentState.topRatedMovies,
        isPopularLoadingMore:
            currentState.isPopularLoadingMore,
        isTrendingLoadingMore:
            currentState.isTrendingLoadingMore,
        isNowPlayingLoadingMore: true,
        isTopRatedLoadingMore:
            currentState.isTopRatedLoadingMore,
      ),
    );

    try {
      final nextPage = nowPlayingPage + 1;

      final movies = await getNowPlayingMovies(
        nextPage,
      );

      if (movies.isEmpty) {
        nowPlayingHasReachedEnd = true;
      } else {
        nowPlayingPage = nextPage;

        emit(
          HomeLoaded(
            popularMovies: currentState.popularMovies,
            trendingMovies: currentState.trendingMovies,
            nowPlayingMovies: [
              ...currentState.nowPlayingMovies,
              ...movies,
            ],
            topRatedMovies: currentState.topRatedMovies,
            isPopularLoadingMore:
                currentState.isPopularLoadingMore,
            isTrendingLoadingMore:
                currentState.isTrendingLoadingMore,
            isNowPlayingLoadingMore: false,
            isTopRatedLoadingMore:
                currentState.isTopRatedLoadingMore,
          ),
        );
      }
    } catch (e) {
    }

    isNowPlayingLoadingMore = false;

    final latestState = state;

    if (latestState is HomeLoaded) {
      emit(
        HomeLoaded(
          popularMovies: latestState.popularMovies,
          trendingMovies: latestState.trendingMovies,
          nowPlayingMovies: latestState.nowPlayingMovies,
          topRatedMovies: latestState.topRatedMovies,
          isPopularLoadingMore:
              latestState.isPopularLoadingMore,
          isTrendingLoadingMore:
              latestState.isTrendingLoadingMore,
          isNowPlayingLoadingMore: false,
          isTopRatedLoadingMore:
              latestState.isTopRatedLoadingMore,
        ),
      );
    }
  }



  Future<void> _loadMoreTopRatedMovies(
    LoadMoreTopRatedMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (isTopRatedLoadingMore ||
        topRatedHasReachedEnd) {
      return;
    }

    final currentState = state;

    if (currentState is! HomeLoaded) {
      return;
    }

    isTopRatedLoadingMore = true;

    emit(
      HomeLoaded(
        popularMovies: currentState.popularMovies,
        trendingMovies: currentState.trendingMovies,
        nowPlayingMovies: currentState.nowPlayingMovies,
        topRatedMovies: currentState.topRatedMovies,
        isPopularLoadingMore:
            currentState.isPopularLoadingMore,
        isTrendingLoadingMore:
            currentState.isTrendingLoadingMore,
        isNowPlayingLoadingMore:
            currentState.isNowPlayingLoadingMore,
        isTopRatedLoadingMore: true,
      ),
    );

    try {
      final nextPage = topRatedPage + 1;

      final movies = await getTopRatedMovies(
        nextPage,
      );

      if (movies.isEmpty) {
        topRatedHasReachedEnd = true;
      } else {
        topRatedPage = nextPage;

        emit(
          HomeLoaded(
            popularMovies: currentState.popularMovies,
            trendingMovies: currentState.trendingMovies,
            nowPlayingMovies: currentState.nowPlayingMovies,
            topRatedMovies: [
              ...currentState.topRatedMovies,
              ...movies,
            ],
            isPopularLoadingMore:
                currentState.isPopularLoadingMore,
            isTrendingLoadingMore:
                currentState.isTrendingLoadingMore,
            isNowPlayingLoadingMore:
                currentState.isNowPlayingLoadingMore,
            isTopRatedLoadingMore: false,
          ),
        );
      }
    } catch (e) {
    }

    isTopRatedLoadingMore = false;

    final latestState = state;

    if (latestState is HomeLoaded) {
      emit(
        HomeLoaded(
          popularMovies: latestState.popularMovies,
          trendingMovies: latestState.trendingMovies,
          nowPlayingMovies: latestState.nowPlayingMovies,
          topRatedMovies: latestState.topRatedMovies,
          isPopularLoadingMore:
              latestState.isPopularLoadingMore,
          isTrendingLoadingMore:
              latestState.isTrendingLoadingMore,
          isNowPlayingLoadingMore:
              latestState.isNowPlayingLoadingMore,
          isTopRatedLoadingMore: false,
        ),
      );
    }
  }
}