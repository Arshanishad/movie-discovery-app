import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/home/presentation/pages/splash_screen.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_bloc.dart';

void main() {
  runApp(BlocProvider(create: (_)=>NavbarBloc(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie discovery app',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'SF Pro Display',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
