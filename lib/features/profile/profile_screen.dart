import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_bloc.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_event.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_state.dart';
import 'package:flutter_application_tripmate/features/profile/pages/about_app_screen.dart';
import 'package:flutter_application_tripmate/features/profile/pages/edit_profile_screen.dart';
import 'package:flutter_application_tripmate/features/profile/pages/help_support_screen.dart';
import 'package:flutter_application_tripmate/features/profile/pages/privacy_policy_screen.dart';
import 'package:flutter_application_tripmate/features/profile/pages/settings_screen.dart';
import 'package:flutter_application_tripmate/features/profile/pages/terms_conditions_screen.dart';
import 'package:flutter_application_tripmate/view/auth/data/auth_service.dart';
import 'package:flutter_application_tripmate/view/auth/logic/auth_bloc/auth_bloc.dart';
import 'package:flutter_application_tripmate/view/auth/logic/auth_bloc/auth_event.dart';
import 'package:flutter_application_tripmate/widgets/main_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';
  String? _userPhotoPath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final User? user = _authService.currentUser;
    if (user == null) return;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!mounted) return;
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _userName = data['name'] ?? 'User';
          _userEmail = data['email'] ?? user.email ?? '';
          _userPhotoPath = data['photoPath'];
        });
      } else {
        setState(() {
          _userName = user.displayName ?? 'User';
          _userEmail = user.email ?? '';
        });
      }
    } catch (_) {
      // Fallback to initial static state if offline or no user doc
    }
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out of TripMate?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radius8),
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      if (!mounted) return;
      context.read<AuthBloc>().add(const AuthLogoutRequestedEvent());
      await _authService.logOut();
      if (!mounted) return;
      context.router.replace(const LoginRoute());
    }
  }

  void _navigateToPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<void> _openEditProfile([String? currentName, String? currentEmail]) async {
    final result = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          currentName: currentName ?? _userName,
          currentEmail: currentEmail ?? _userEmail,
          currentPhotoPath: _userPhotoPath,
        ),
      ),
    );

    if (result is Map) {
      final updatedName = result['name'] as String?;
      final updatedPhotoPath = result['photoPath'] as String?;
      if (updatedName != null && updatedName.isNotEmpty) {
        if (!mounted) return;
        context.read<ProfileBloc>().add(
              UpdateProfileEvent(name: updatedName, phone: ''),
            );
        setState(() {
          _userName = updatedName;
          if (updatedPhotoPath != null) {
            _userPhotoPath = updatedPhotoPath;
          }
        });
      }
    } else if (result is String && result.isNotEmpty) {
      if (!mounted) return;
      context.read<ProfileBloc>().add(
            UpdateProfileEvent(name: result, phone: ''),
          );
      setState(() {
        _userName = result;
      });
    }
    _loadUserData();
  }

  void _showTripHistory() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trip History', style: AppTextStyles.title),
            const SizedBox(height: AppSizes.spacing16),
            ListTile(
              leading: const Icon(Icons.flight_takeoff_rounded, color: AppColors.primaryColor),
              title: const Text('Paris, France'),
              subtitle: const Text('Completed: July 2025 • 5 Nights'),
              trailing: const Icon(Icons.check_circle_rounded, color: AppColors.greenColor),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.beach_access_rounded, color: Colors.orange),
              title: const Text('Bali, Indonesia'),
              subtitle: const Text('Completed: Nov 2025 • 7 Nights'),
              trailing: const Icon(Icons.check_circle_rounded, color: AppColors.greenColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 4,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.spacing8),
            Text('Profile', style: AppTextStyles.heading),
            const SizedBox(height: AppSizes.spacing20),

            // 👤 User Profile Card
            _buildProfileHeaderCard(),

            const SizedBox(height: AppSizes.spacing24),

            // 🧳 Activity & Trips Section
            _buildSectionHeader('Activity & Trips'),
            const SizedBox(height: AppSizes.spacing12),
            _buildMenuCard([
              _buildMenuItem(
                icon: Icons.receipt_long_outlined,
                iconColor: AppColors.primaryColor,
                title: 'My Bookings',
                subtitle: 'View active and past hotel bookings',
                onTap: () => context.router.replace(const MyBookingRoute()),
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.favorite_border_rounded,
                iconColor: AppColors.redColor,
                title: 'Favorites',
                subtitle: 'Saved destinations & hotels',
                onTap: () => context.router.replace(const FavoriteRoute()),
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.card_travel_rounded,
                iconColor: Colors.orange,
                title: 'Trip History',
                subtitle: 'Completed travel logs',
                onTap: _showTripHistory,
              ),
            ]),

            const SizedBox(height: AppSizes.spacing24),

            // ⚙️ Preferences & Information Section
            _buildSectionHeader('Preferences & Information'),
            const SizedBox(height: AppSizes.spacing12),
            _buildMenuCard([
              _buildMenuItem(
                icon: Icons.settings_outlined,
                iconColor: Colors.blueGrey,
                title: 'Settings',
                subtitle: 'App preferences and notifications',
                onTap: () => _navigateToPage(const SettingsScreen()),
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.help_outline_rounded,
                iconColor: Colors.teal,
                title: 'Help & Support',
                subtitle: 'FAQs and customer support',
                onTap: () => _navigateToPage(const HelpSupportScreen()),
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.info_outline_rounded,
                iconColor: AppColors.primaryColor,
                title: 'About TripMate',
                subtitle: 'App version and company info',
                onTap: () => _navigateToPage(const AboutAppScreen()),
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.lock_outline_rounded,
                iconColor: Colors.indigo,
                title: 'Privacy Policy',
                subtitle: 'How we handle your data',
                onTap: () => _navigateToPage(const PrivacyPolicyScreen()),
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.description_outlined,
                iconColor: Colors.brown,
                title: 'Terms & Conditions',
                subtitle: 'Legal usage rules',
                onTap: () => _navigateToPage(const TermsConditionsScreen()),
              ),
            ]),

            const SizedBox(height: AppSizes.spacing24),

            // 🚪 Logout Button Card
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppSizes.radius16),
                border: Border.all(
                  color: AppColors.redColor.withValues(alpha: 0.2),
                ),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppSizes.spacing8),
                  decoration: BoxDecoration(
                    color: AppColors.redColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.redColor,
                    size: AppSizes.icon20,
                  ),
                ),
                title: Text(
                  'Logout',
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.redColor,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.redColor,
                ),
                onTap: _handleLogout,
              ),
            ),

            const SizedBox(height: AppSizes.spacing24),

            // App Version Footer
            Center(
              child: Column(
                children: [
                  Text(
                    'TripMate v1.0.0',
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing4),
                  Text(
                    'Made with ❤️ for Travelers',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11,
                      color: AppColors.greyColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spacing24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeaderCard() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String name = _userName;
        String email = _userEmail;

        if (state is ProfileLoaded) {
          name = state.userProfile.name;
          email = state.userProfile.email;
        }

        final hasPhoto = _userPhotoPath != null &&
            _userPhotoPath!.isNotEmpty &&
            File(_userPhotoPath!).existsSync();

        return Container(
          padding: const EdgeInsets.all(AppSizes.spacing16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppSizes.radius16),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                    backgroundImage:
                        hasPhoto ? FileImage(File(_userPhotoPath!)) : null,
                    child: !hasPhoto
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: AppTextStyles.heading.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 28,
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _openEditProfile(name, email),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 14,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSizes.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.spacing4),
                    Text(
                      email,
                      style: AppTextStyles.caption.copyWith(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.spacing8),
                    InkWell(
                      onTap: () => _openEditProfile(name, email),
                      child: Text(
                        'Edit Profile',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.title.copyWith(
        fontSize: 14,
        color: AppColors.greyColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
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

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16,
        vertical: AppSizes.spacing4,
      ),
      leading: Container(
        padding: const EdgeInsets.all(AppSizes.spacing8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: AppSizes.icon20),
      ),
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption.copyWith(fontSize: 12),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.greyColor,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.8,
      indent: 56,
      endIndent: 16,
      color: Color(0xFFF0F0F0),
    );
  }
}
