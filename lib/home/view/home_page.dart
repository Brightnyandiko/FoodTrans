import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_trans/home/view/widgets/bottom_navigation.dart';
// import 'package:food_trans/home/view/widgets/category_section.dart';
// import 'package:food_trans/home/view/widgets/food_grid.dart';
// import 'package:food_trans/home/view/widgets/header_section.dart';
import '../../navigation/main_navigation_page.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../widgets/category_section.dart';
import '../../widgets/food_grid.dart';
import '../../widgets/header_section.dart';
import '../cubit/home_cubit.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  static Page<void> page() => MaterialPage<void>(
    child: const MainNavigationPage()
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().loadData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is HomeLoaded) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Color(0xFF2C2C2C), Color(0xFF1A1A1A)],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    HeaderSection(location: state.location),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          children: [
                            CategorySection(categories: state.categories),
                            Expanded(
                              child: FoodGrid(foodItems: state.foodItems),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
      // bottomNavigationBar: BottomNavigation(selectedIndex: 0, onItemTapped: (int ) { 0; },),
    );
  }
}

// Keep this for backward compatibility if needed elsewhere
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => MaterialPage<void>(
    child: BlocProvider(
      create: (context) => HomeCubit()..loadData(),
      child: const AppNavigationWrapper(), // Use the wrapper instead
    ),
  );

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}