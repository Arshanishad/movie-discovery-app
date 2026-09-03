import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/features/download/presentation/pages/download_screen.dart';
import 'package:movie_discovery_app/features/home/presentation/pages/home_page.dart';
import 'package:movie_discovery_app/features/home/presentation/pages/splash_screen.dart';
import 'package:movie_discovery_app/features/home/presentation/pages/username_screen.dart';
import 'package:movie_discovery_app/features/more/presentation/pages/more_screen.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_bloc.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_event.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_state.dart';
import 'package:movie_discovery_app/features/search/presentation/search_screen.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  final List<Widget> pages = const [
    HomePage(),
    SearchScreen(),
    SplashScreen(),
    DownloadScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<NavbarBloc>().add(ChangeNavbarIndex(index));
            },
            type: BottomNavigationBarType.fixed,
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
                icon: Image.asset(ImageConstants.commingsoonIcon),
                activeIcon: Image.asset(ImageConstants.commingsoonIcon),
                label: 'Coming soon',
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
