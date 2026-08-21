import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/bookings/data/booking_store.dart';
import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';
import 'package:intl/intl.dart';

@RoutePage()
class BookingSummaryScreen extends StatelessWidget {
  final BookingModel booking;

  const BookingSummaryScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd MMM yyyy');

    final nights = booking.checkOutDate.difference(booking.checkInDate).inDays;

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    final tax = booking.totalAmount - (booking.roomPrice * nights);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          'Booking Details',
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radius16),
              child: CachedNetworkImage(
                imageUrl: booking.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.image,
                    size: 40,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spacing20),

            // Hotel Name
            Text(
              booking.hotelName,
              style: AppTextStyles.heading.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Location
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppColors.greyColor,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    booking.location,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spacing20),

            // Booking ID
            _buildInfoCard(
              title: 'Booking ID',
              value: booking.id,
              icon: Icons.confirmation_number_outlined,
            ),

            const SizedBox(height: AppSizes.spacing12),

            // Room
            _buildInfoCard(
              title: 'Room',
              value: booking.roomName,
              icon: Icons.king_bed_outlined,
            ),

            const SizedBox(height: AppSizes.spacing12),

            // Guests
            _buildInfoCard(
              title: 'Guests',
              value: '${booking.guestCount} Adults',
              icon: Icons.people_outline_rounded,
            ),

            const SizedBox(height: AppSizes.spacing20),

            // Stay Details
            Text(
              'Stay Details',
              style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: AppSizes.spacing12),

            Container(
              padding: const EdgeInsets.all(AppSizes.spacing16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppSizes.radius16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDateColumn(
                      title: 'Check-In',
                      date: dateFormatter.format(booking.checkInDate),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.greyColor.withValues(alpha: 0.2),
                  ),
                  Expanded(
                    child: _buildDateColumn(
                      title: 'Check-Out',
                      date: dateFormatter.format(booking.checkOutDate),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spacing20),

            // Price Details
            Text(
              'Price Details',
              style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: AppSizes.spacing12),

            Container(
              padding: const EdgeInsets.all(AppSizes.spacing16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppSizes.radius16),
              ),
              child: Column(
                children: [
                  _buildPriceRow(
                    'Room Price',
                    currencyFormatter.format(booking.roomPrice),
                  ),

                  const SizedBox(height: AppSizes.spacing8),

                  _buildPriceRow('Nights', '$nights nights'),

                  const SizedBox(height: AppSizes.spacing8),

                  _buildPriceRow('Taxes & Fees', currencyFormatter.format(tax)),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSizes.spacing12),
                    child: Divider(),
                  ),

                  _buildPriceRow(
                    'Total Amount',
                    currencyFormatter.format(booking.totalAmount),
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spacing20),

            // Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.spacing16),
              decoration: BoxDecoration(
                color: _getStatusBackground(booking.status),
                borderRadius: BorderRadius.circular(AppSizes.radius16),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(booking.status),
                    color: _getStatusColor(booking.status),
                  ),
                  const SizedBox(width: AppSizes.spacing12),
                  Text(
                    _getStatusLabel(booking.status),
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(booking.status),
                    ),
                  ),
                ],
              ),
            ),

            // Cancel Booking
            if (booking.status == BookingStatus.upcoming) ...[
              const SizedBox(height: AppSizes.spacing20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showCancelDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(AppSizes.spacing48),
                    side: BorderSide(color: AppColors.redColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radius12),
                    ),
                  ),
                  child: Text(
                    'Cancel Booking',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(BuildContext context) async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Cancel Booking?'),
          content: const Text('Are you sure you want to cancel this booking?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text(
                'Yes, Cancel',
                style: TextStyle(
                  color: AppColors.redColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldCancel != true || !context.mounted) {
      return;
    }

    await BookingStore.cancelBooking(booking.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking cancelled successfully')),
    );

    context.router.pop();
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacing16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(width: AppSizes.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateColumn({required String title, required String date}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.caption.copyWith(color: AppColors.greyColor),
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.body.copyWith(
            color: isTotal ? AppColors.blackColor : AppColors.greyColor,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.body.copyWith(
            color: isTotal ? AppColors.primaryColor : AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getStatusLabel(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return 'Upcoming Booking';
      case BookingStatus.completed:
        return 'Completed Booking';
      case BookingStatus.cancelled:
        return 'Cancelled Booking';
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return AppColors.primaryColor;
      case BookingStatus.completed:
        return AppColors.greenColor;
      case BookingStatus.cancelled:
        return AppColors.redColor;
    }
  }

  Color _getStatusBackground(BookingStatus status) {
    return _getStatusColor(status).withValues(alpha: 0.1);
  }

  IconData _getStatusIcon(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return Icons.event_available_rounded;
      case BookingStatus.completed:
        return Icons.check_circle_outline_rounded;
      case BookingStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }
}
