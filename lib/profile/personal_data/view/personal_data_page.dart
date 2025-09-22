// lib/personal_data/view/personal_data_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/profile/personal_data/view/personal_data_view.dart';

// import '../../repositories/profile_repository.dart';
// import '../../profile/models/user_profile.dart';
import '../../../repositories/profile_repository.dart';
import '../../models/user_profile.dart';
import '../cubit/personal_data_cubit.dart';
// import 'personal_data_view.dart';

class PersonalDataPage extends StatelessWidget {
  const PersonalDataPage({
    super.key,
    required this.user,
  });

  final UserProfile user;

  static Route<UserProfile?> route(UserProfile user) {
    return MaterialPageRoute<UserProfile?>(
      builder: (_) => PersonalDataPage(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalDataCubit(
        profileRepository: ProfileRepository(),
        initialUser: user,
      ),
      child: const PersonalDataView(),
    );
  }
}