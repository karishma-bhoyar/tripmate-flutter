import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/bookings/data/booking_store.dart';
import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';
import 'package:flutter_application_tripmate/widgets/main_layout.dart';
import 'package:intl/intl.dart';

String _getStatusLabel(BookingStatus status) {
  switch (status) {
    case BookingStatus.upcoming:
      return "Upcoming";
    case BookingStatus.completed:
      return "Completed";
    case BookingStatus.cancelled:
      return "Cancelled";
  }
}

Color _getStatusTextColor(BookingStatus status) {
  switch (status) {
    case BookingStatus.upcoming:
      return AppColors.primaryColor;
    case BookingStatus.completed:
      return AppColors.greenColor;
    case BookingStatus.cancelled:
      return AppColors.redColor;
  }
}

Color _getStatusBgColor(BookingStatus status) {
  switch (status) {
    case BookingStatus.upcoming:
      return AppColors.primaryColor.withValues(alpha: 0.1);
    case BookingStatus.completed:
      return AppColors.greenColor.withValues(alpha: 0.1);
    case BookingStatus.cancelled:
      return AppColors.redColor.withValues(alpha: 0.1);
  }
}

@RoutePage()
class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    BookingStore.loadBooking();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search bookings...',
                      border: InputBorder.none,
                      // Back button
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearching = false;
                            _searchQuery = '';
                            _searchController.clear();
                          });
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  )
                : Text(
                    "My Bookings",
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
            actions: [
              if (!_isSearching)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search, color: AppColors.greyColor),
                ),
            ],
            bottom: TabBar(
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.greyColor,
              labelStyle: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: AppTextStyles.body.copyWith(fontSize: 14),
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Completed"),
                Tab(text: "Cancelled"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildBookingList(BookingStatus.upcoming),
              _buildBookingList(BookingStatus.completed),
              _buildBookingList(BookingStatus.cancelled),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList(BookingStatus status) {
    // final filtered = _booking.where((b) => b.status == status).toList();
    final dateFormatter = DateFormat("dd MMM yyyy");
    final filtered = BookingStore.bookings.where((booking) {
      final matchesStatus = booking.status == status;
      final query = _searchQuery.toLowerCase().trim();
      final matchesSearch =
          booking.hotelName.toLowerCase().contains(query) ||
          booking.location.toLowerCase().contains(query) ||
          booking.roomName.toLowerCase().contains(query);
      return matchesStatus && matchesSearch;
    }).toList();
    final currencyFormatter = NumberFormat.currency(
      locale: "en_IN",
      symbol: '₹',
      decimalDigits: 0,
    );
    if (filtered.isEmpty) {
      return Center(
        child: Text(
          "No Bookings found",
          style: AppTextStyles.body.copyWith(color: AppColors.greyColor),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacing16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final booking = filtered[index];
        final dates =
            '${dateFormatter.format(booking.checkInDate)} - '
            '${dateFormatter.format(booking.checkOutDate)}';

        return InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          onTap: () {
            context.router.push(BookingSummaryRoute(booking: booking));
            if (!mounted) return;
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.only(bottom: AppSizes.spacing16),
            padding: const EdgeInsets.all(AppSizes.spacing12),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(AppSizes.radius16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(
                    AppSizes.radius12,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: booking.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 80,
                      height: 80,
                      color: AppColors.greyColor.withValues(alpha: 0.1),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 80,
                      color: AppColors.greyColor.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.image,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spacing16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.hotelName,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.location,
                        style: AppTextStyles.caption.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dates,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 11,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.spacing16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currencyFormatter.format(booking.totalAmount),
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusBgColor(booking.status),
                        borderRadius: BorderRadius.circular(AppSizes.radius8),
                      ),
                      child: Text(
                        _getStatusLabel(booking.status),
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusTextColor(booking.status),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
