import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/home_cubit.dart';
import '../home/cubit/home_cubit.dart';
import 'main_navigation_page.dart';

class AppNavigationWrapper extends StatelessWidget {
  const AppNavigationWrapper({super.key});

  // This method is used by your authentication routing
  static Page<void> page() => MaterialPage<void>(
    child: BlocProvider(
      create: (context) => HomeCubit()..loadData(), // Keep your existing logic
      child: const AppNavigationWrapper(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return const MainNavigationPage(); // Show the main navigation
  }
}