import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';
import 'package:intl/intl.dart';

@RoutePage()
class BookingViewDetailsScreen extends StatelessWidget {
  final BookingModel booking;

  const BookingViewDetailsScreen({super.key, required this.booking});

  void _showTicketExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ),
              const SizedBox(height: AppSizes.spacing16),
              Text(
                'E-Ticket Generated',
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: AppSizes.spacing8),
              Text(
                'Your ticket for ${booking.hotelName} (ID: ${booking.id}) has been exported successfully.',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.greyColor,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacing24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radius12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ticket saved to Downloads!')),
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Save PDF'),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacing12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Share',
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sharing ticket receipt...')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd MMM yyyy');

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Booking Details',
        onBackPressed: () => context.router.pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.hotelName,
              style: AppTextStyles.heading.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacing8),
            Text(
              booking.location,
              style: AppTextStyles.body.copyWith(color: AppColors.greyColor),
            ),
            const SizedBox(height: AppSizes.spacing24),
            Text(
              'Booking Information',
              style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSizes.spacing12),
            _buildInfoTile('Booking ID', booking.id),
            _buildInfoTile('Room', booking.roomName),
            _buildInfoTile(
              'Check-In',
              dateFormatter.format(booking.checkInDate),
            ),
            _buildInfoTile(
              'Check-Out',
              dateFormatter.format(booking.checkOutDate),
            ),
            _buildInfoTile('Guests', '${booking.guestCount} Adults'),
            _buildInfoTile('Total Amount', '₹${booking.totalAmount.round()}'),
            _buildInfoTile('Status', booking.status.name.toUpperCase()),
            const SizedBox(height: AppSizes.spacing24),
            PrimaryButton(
              text: 'Download & Share Ticket',
              onPressed: () => _showTicketExportDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacing12),
      padding: const EdgeInsets.all(AppSizes.spacing16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.caption.copyWith(color: AppColors.greyColor),
          ),
          const SizedBox(width: AppSizes.spacing16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
