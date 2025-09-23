// lib/settings/view/settings_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../app/cubit/app_cubit.dart';
import '../../app/bloc/app_bloc.dart';
import '../cubit/settings_cubit.dart';
import '../models/app_settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, l10n),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is SettingsLoaded) {
            // Update app locale when language changes through AppBloc
            context.read<AppBloc>().changeLocale(state.settings.language.locale);
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsLoaded || state is PermissionRequesting) {
            AppSettings settings;
            bool isRequesting = false;

            if (state is SettingsLoaded) {
              settings = state.settings;
            } else if (state is PermissionRequesting) {
              settings = state.settings;
              isRequesting = true;
            } else {
              return const SizedBox();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(l10n.profile.toUpperCase()),
                  const SizedBox(height: 16),
                  _buildToggleItem(
                    title: l10n.pushNotification,
                    value: settings.pushNotificationsEnabled,
                    onChanged: isRequesting ? null : (value) {
                      context.read<SettingsCubit>().togglePushNotifications(value);
                    },
                    isLoading: isRequesting,
                  ),
                  const SizedBox(height: 16),
                  _buildToggleItem(
                    title: l10n.location,
                    value: settings.locationEnabled,
                    onChanged: isRequesting ? null : (value) {
                      context.read<SettingsCubit>().toggleLocation(value);
                    },
                    isLoading: isRequesting,
                  ),
                  const SizedBox(height: 16),
                  _buildNavigationItem(
                    title: l10n.language,
                    value: _getLanguageDisplayName(settings.language, l10n),
                    onTap: () => _showLanguagePicker(context, settings.language, l10n),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader(l10n.other.toUpperCase()),
                  const SizedBox(height: 25),
                  _buildNavigationItem(
                    title: l10n.aboutTickets,
                    onTap: () => _navigateToAboutTickets(context),
                  ),
                  const SizedBox(height: 25),
                  _buildNavigationItem(
                    title: l10n.privacyPolicy,
                    onTap: () => _navigateToPrivacyPolicy(context),
                  ),
                  const SizedBox(height: 25),
                  _buildNavigationItem(
                    title: l10n.termsAndConditions,
                    onTap: () => _navigateToTermsAndConditions(context),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Text(
        l10n.settings,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool isLoading = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.orange,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
      ],
    );
  }

  Widget _buildNavigationItem({
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                if (value != null) ...[
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageDisplayName(AppLanguage language, AppLocalizations l10n) {
    switch (language) {
      case AppLanguage.english:
        return l10n.english;
      case AppLanguage.spanish:
        return l10n.spanish;
      case AppLanguage.french:
        return l10n.french;
    }
  }

  void _showLanguagePicker(BuildContext context, AppLanguage currentLanguage, AppLocalizations l10n) {
    final settingsCubit = context.read<SettingsCubit>();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.selectLanguage,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              ...AppLanguage.values.map((language) {
                return ListTile(
                  title: Text(_getLanguageDisplayName(language, l10n)),
                  trailing: currentLanguage == language
                      ? const Icon(Icons.check, color: Colors.orange)
                      : null,
                  onTap: () {
                    settingsCubit.changeLanguage(language);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _navigateToAboutTickets(BuildContext context) {
    Navigator.pushNamed(context, '/about-tickets');
  }

  void _navigateToPrivacyPolicy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy-policy');
  }

  void _navigateToTermsAndConditions(BuildContext context) {
    Navigator.pushNamed(context, '/terms-conditions');
  }
}