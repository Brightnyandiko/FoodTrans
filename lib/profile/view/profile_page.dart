// lib/profile/view/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/profile_repository.dart';
import '../../repositories/order_repository.dart';
import '../cubit/profile_cubit.dart';
import 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        profileRepository: ProfileRepository(),
        orderRepository: OrderRepository(),
      )..loadProfile(),
      child: const ProfileView(),
    );
  }
}