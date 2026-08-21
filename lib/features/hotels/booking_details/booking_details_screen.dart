import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/hotels/select_room/select_room_screen.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';
import 'package:intl/intl.dart';

@RoutePage()
class BookingDetailsScreen extends StatefulWidget {
  final RoomData roomData;
  final String? hotelName;
  final String? location;
  const BookingDetailsScreen({
    required this.roomData,
    this.hotelName,
    this.location,
    super.key,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  DateTime _checkInDate = DateTime.now().add(const Duration(days: 1));
  DateTime _checkOutDate = DateTime.now().add(const Duration(days: 3));
  int _gestCount = 2;

  int get _nightsCount => _checkOutDate.difference(_checkInDate).inDays;

  // Opens calendar range picker
  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: AppColors.blackColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _checkInDate = picked.start;
        _checkOutDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal = widget.roomData.price * _nightsCount;
    final double tax = subtotal * 0.10; // 10% Taxes & Fees matching Figma
    final double grandTotal = subtotal + tax;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Booking Details',
        onBackPressed: () => context.router.pop(context),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.spacing24,
                  right: AppSizes.spacing24,
                  top: AppSizes.spacing16,
                  bottom: 160,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSelectedRoomSummary(),
                    const SizedBox(height: AppSizes.spacing12),
                    _buildDatePickerSection(),
                    const SizedBox(height: AppSizes.spacing12),
                    _buildGuestsTile(),
                    const SizedBox(height: AppSizes.spacing12),
                    _buildRoomTile(),
                    const SizedBox(height: AppSizes.spacing12),
                    _buildPriceSummary(subtotal, tax, grandTotal),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(grandTotal),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedRoomSummary() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacing16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
            child: CachedNetworkImage(
              imageUrl: widget.roomData.imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 80,
                width: 80,
                color: AppColors.greyColor.withValues(alpha: 0.1),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 80,
                width: 80,
                color: AppColors.greyColor.withValues(alpha: 0.1),
                child: const Icon(Icons.image, color: AppColors.greyColor),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hotelName ?? "The Kayan Resort",
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 12,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Ubud, Bali",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerSection() {
    final dateFormat = DateFormat('dd MMM yyyy');
    return InkWell(
      onTap: () => _selectDateRange(context),
      borderRadius: BorderRadius.circular(AppSizes.radius16),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacing16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          border: Border.all(
            color: AppColors.greyColor.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check-In',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateFormat.format(_checkInDate),
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              size: 18,
              color: AppColors.greyColor.withValues(alpha: 0.5),
            ),
            const SizedBox(width: AppSizes.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check-Out',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateFormat.format(_checkOutDate),
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestsTile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.people_outline_rounded,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: AppSizes.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Guests',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$_gestCount Adults, 0 Children',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _gestCount > 1
                    ? () => setState(() => _gestCount--)
                    : null,
                icon: const Icon(Icons.remove_circle_outline_rounded, size: 20),
                color: AppColors.primaryColor,
              ),
              IconButton(
                onPressed: _gestCount < 8
                    ? () => setState(() => _gestCount++)
                    : null,
                icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoomTile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          const Icon(Icons.king_bed_outlined, color: AppColors.primaryColor),
          const SizedBox(width: AppSizes.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Type',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.roomData.name,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary(double subtotal, double tax, double grandTotal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            border: Border.all(
              color: AppColors.greyColor.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${widget.roomData.price.round()} x $_nightsCount nights',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Text(
                    '₹${subtotal.round()}',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spacing8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Taxes & Fees',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Text(
                    '₹${tax.round()}',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.spacing12),
                child: Divider(height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${grandTotal.round()}',
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(double grandTotal) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacing24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: PrimaryButton(
          text: 'Continue to Payment',
          onPressed: () {
            context.router.push(
              PaymentRoute(
                totalAmount: grandTotal,
                hotelName: widget.hotelName,
                location: widget.location,
                roomData: widget.roomData,
                checkInDate: _checkInDate,
                checkOutDate: _checkOutDate,
                guestCount: _gestCount,
              ),
            );
          },
        ),
      ),
    );
  }
}
