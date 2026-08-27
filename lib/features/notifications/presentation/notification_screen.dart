import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconColor;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconColor,
    this.isRead = false,
  });
}

@RoutePage()
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Booking Confirmed! 🎉',
      message: 'Your stay at Grand Hyatt Dubai is confirmed for next week.',
      time: '2 mins ago',
      icon: Icons.check_circle_rounded,
      iconColor: AppColors.primaryColor,
    ),
    NotificationItem(
      id: '2',
      title: 'Special Discount 🏷️',
      message: 'Get 25% off on Bali Beach Resorts this weekend.',
      time: '1 hour ago',
      icon: Icons.local_offer_rounded,
      iconColor: Colors.amber,
    ),
    NotificationItem(
      id: '3',
      title: 'Flight Reminder ✈️',
      message: 'Don\'t forget to check in for your upcoming travel.',
      time: '1 day ago',
      icon: Icons.flight_takeoff_rounded,
      iconColor: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Notifications',
        actions: [
          if (_notifications.any((n) => !n.isRead))
            TextButton(
              onPressed: () {
                setState(() {
                  for (var n in _notifications) {
                    n.isRead = true;
                  }
                });
              },
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(AppSizes.spacing24),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return Dismissible(
                  key: Key(item.id),
                  onDismissed: (_) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: AppSizes.spacing16),
                    padding: const EdgeInsets.all(AppSizes.spacing16),
                    decoration: BoxDecoration(
                      color: item.isRead
                          ? AppColors.whiteColor
                          : AppColors.primaryColor.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(AppSizes.radius16),
                      border: Border.all(
                        color: AppColors.greyColor.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSizes.spacing10),
                          decoration: BoxDecoration(
                            color: item.iconColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item.icon,
                            color: item.iconColor,
                            size: AppSizes.icon20,
                          ),
                        ),
                        const SizedBox(width: AppSizes.spacing16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: AppTextStyles.title.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    item.time,
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.greyColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spacing4),
                              Text(
                                item.message,
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: AppColors.greyColor,
          ),
          const SizedBox(height: AppSizes.spacing16),
          Text(
            'No Notifications',
            style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.spacing8),
          Text(
            'You\'re all caught up!',
            style: AppTextStyles.caption.copyWith(color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
