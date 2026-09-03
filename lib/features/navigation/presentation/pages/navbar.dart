import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/core/api/api_client.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/features/comming_soon/presentation/pages/comming_soon_screen.dart';
import 'package:movie_discovery_app/features/download/presentation/pages/download_screen.dart';
import 'package:movie_discovery_app/features/home/presentation/pages/home_page.dart';
import 'package:movie_discovery_app/features/more/presentation/pages/more_screen.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_bloc.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_event.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_state.dart';
import 'package:movie_discovery_app/features/search/data/datasource/search_remote_data_source.dart';
import 'package:movie_discovery_app/features/search/data/repositories/search_repository_impl.dart';
import 'package:movie_discovery_app/features/search/domain/usecase/search_movies.dart';
import 'package:movie_discovery_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:movie_discovery_app/features/search/presentation/search_screen.dart';

class Navbar extends StatelessWidget {
  final String username;

  const Navbar({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        final List<Widget> pages = [
          HomePage(username: username),
          BlocProvider(
            create: (_) {
              final apiClient = ApiClient();
              final remoteDataSource = SearchRemoteDataSource(apiClient);
              final repository = SearchRepositoryImpl(remoteDataSource);
              final searchMovies = SearchMovies(repository);
              return SearchBloc(searchMovies);
            },
            child: const SearchScreen(),
          ),
          const CommingSoonScreen(),
          const DownloadScreen(),
          const MoreScreen(),
        ];
        return Scaffold(
          backgroundColor: Colors.black,
          body: IndexedStack(index: state.selectedIndex, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<NavbarBloc>().add(ChangeNavbarIndex(index));
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageConstants.commingsoonIcon,
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  ImageConstants.commingsoonIcon,
                  width: 24,
                  height: 24,
                ),
                label: 'Coming Soon',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.download_outlined),
                activeIcon: Icon(Icons.download),
                label: 'Downloads',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                activeIcon: Icon(Icons.menu),
                label: 'More',
              ),
            ],
          ),
        );
      },
    );
  }
}
