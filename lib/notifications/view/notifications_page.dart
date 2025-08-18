import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notifications_cubit.dart';
import 'notifications_view.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const NotificationsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit()..loadNotifications(),
      child: const NotificationsView(),
    );
  }
}