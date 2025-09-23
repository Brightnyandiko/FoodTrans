// lib/settings/view/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/settings_repository.dart';
import '../cubit/settings_cubit.dart';
import 'settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        settingsRepository: SettingsRepository(),
      )..loadSettings(),
      child: const SettingsView(),
    );
  }
}