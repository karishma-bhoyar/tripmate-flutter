import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/core/theme/theme_cubit.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailAlerts = true;
  String _selectedCurrency = 'INR (₹)';
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Settings',
        subtitle: 'App preferences and notifications',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Notifications'),
            const SizedBox(height: AppSizes.spacing12),
            _buildCard([
              SwitchListTile(
                activeTrackColor: AppColors.primaryColor,
                title: Text('Push Notifications', style: AppTextStyles.body),
                subtitle: Text(
                  'Receive instant trip and booking updates',
                  style: AppTextStyles.caption,
                ),
                value: _pushNotifications,
                onChanged: (val) => setState(() => _pushNotifications = val),
              ),
              const Divider(height: 1),
              SwitchListTile(
                activeTrackColor: AppColors.primaryColor,
                title: Text('Email Alerts', style: AppTextStyles.body),
                subtitle: Text(
                  'Receive booking receipts and promotional offers',
                  style: AppTextStyles.caption,
                ),
                value: _emailAlerts,
                onChanged: (val) => setState(() => _emailAlerts = val),
              ),
            ]),
            const SizedBox(height: AppSizes.spacing24),
            _buildSectionTitle('Appearance & Regional'),
            const SizedBox(height: AppSizes.spacing12),
            _buildCard([
              SwitchListTile(
                activeTrackColor: AppColors.primaryColor,
                title: Text('Dark Mode', style: AppTextStyles.body),
                subtitle: Text(
                  'Enable comfortable night theme',
                  style: AppTextStyles.caption,
                ),
                value: isDarkMode,
                onChanged: (val) {
                  context.read<ThemeCubit>().toggleTheme(val);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text('Currency', style: AppTextStyles.body),
                subtitle: Text(_selectedCurrency, style: AppTextStyles.caption),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: _showCurrencyPicker,
              ),
              const Divider(height: 1),
              ListTile(
                title: Text('Language', style: AppTextStyles.body),
                subtitle: Text(_selectedLanguage, style: AppTextStyles.caption),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: _showLanguagePicker,
              ),
            ]),
            const SizedBox(height: AppSizes.spacing24),
            _buildSectionTitle('Storage & Data'),
            const SizedBox(height: AppSizes.spacing12),
            _buildCard([
              ListTile(
                title: Text('Clear Search Cache', style: AppTextStyles.body),
                subtitle: Text('Frees up local storage space', style: AppTextStyles.caption),
                trailing: const Icon(Icons.cleaning_services_rounded, color: AppColors.greyColor),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cache cleared successfully!')),
                  );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.title.copyWith(
        fontSize: 14,
        color: AppColors.greyColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  void _showCurrencyPicker() {
    final currencies = ['INR (₹)', 'USD (\$)', 'EUR (€)', 'GBP (£)'];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: currencies
            .map(
              (c) => ListTile(
                title: Text(c),
                trailing: _selectedCurrency == c
                    ? const Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
                onTap: () {
                  setState(() => _selectedCurrency = c);
                  Navigator.pop(ctx);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _showLanguagePicker() {
    final languages = ['English', 'Hindi', 'French', 'Spanish'];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: languages
            .map(
              (l) => ListTile(
                title: Text(l),
                trailing: _selectedLanguage == l
                    ? const Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
                onTap: () {
                  setState(() => _selectedLanguage = l);
                  Navigator.pop(ctx);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
