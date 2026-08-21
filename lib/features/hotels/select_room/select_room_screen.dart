import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';

class RoomData {
  final String name;
  final String imageUrl;
  final String bedType;
  final String size;
  final double price;
  final List<String> amenities;

  RoomData({
    required this.name,
    required this.imageUrl,
    required this.bedType,
    required this.size,
    required this.price,
    required this.amenities,
  });
}

@RoutePage()
class SelectRoomScreen extends StatefulWidget {
  final String? hotelName;
  final String? location;
  const SelectRoomScreen({super.key, this.hotelName, this.location});

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  int _selectedRoomsIndex = 0;
  final List<RoomData> _rooms = [
    RoomData(
      name: 'Deluxe Room Garden View',
      imageUrl:
          'https://images.unsplash.com/photo-1611891487122-207579d67d98?auto=format&fit=crop&w=600&q=80',
      bedType: '1 Queen Bed',
      size: '32 m²',
      price: 18500.0,
      amenities: ['Free Wi-Fi', 'Air Conditioning', 'Breakfast Included'],
    ),
    RoomData(
      name: 'Premium Suite Valley View',
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
      bedType: '1 King Bed',
      size: '48 m²',
      amenities: [
        'Free Wi-Fi',
        'Air Conditioning',
        'Breakfast Included',
        'Bathtub',
      ],
      price: 24500.0,
    ),
    RoomData(
      name: 'Presidential Private Pool Villa',
      imageUrl:
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80',
      bedType: '1 King Bed & 1 Daybed',
      size: '120 m²',
      amenities: [
        'Free Wi-Fi',
        'Private Pool',
        'Butler Service',
        'All-Inclusive',
      ],
      price: 45000.0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final selectedRooms = _rooms[_selectedRoomsIndex];
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Room',
        subtitle: widget.hotelName ?? 'The Dolder Grand',
        onBackPressed: () {
          context.router.pop(context);
        },
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: AppSizes.spacing24,
                right: AppSizes.spacing24,
                top: AppSizes.spacing16,
                bottom: 160, // Padding to avoid overlap with bottom action bar
              ),
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                return _buildRoomCard(_rooms[index], index);
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(selectedRooms),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(RoomData room, int index) {
    final isSelected = _selectedRoomsIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRoomsIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: AppSizes.spacing20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.greyColor.withValues(alpha: 0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: CachedNetworkImage(
                imageUrl: room.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 160,
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 160,
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Icon(Icons.image, color: AppColors.greyColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.name,
                          style: AppTextStyles.title.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      Radio<int>(
                        value: index,
                        // ignore: deprecated_member_use
                        groupValue: _selectedRoomsIndex,
                        activeColor: AppColors.primaryColor,
                        // ignore: deprecated_member_use
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedRoomsIndex = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Row(
                    children: [
                      const Icon(
                        Icons.king_bed_outlined,
                        size: 16,
                        color: AppColors.greyColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        room.bedType,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.square_foot_outlined,
                        size: 16,
                        color: AppColors.greyColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        room.size,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: room.amenities.map((amenity) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(AppSizes.radius8),
                        ),
                        child: Text(
                          amenity,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSizes.spacing16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Price/night',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${room.price.round()}',
                            style: AppTextStyles.title.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Tax & fees included',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(RoomData room) {
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${room.price.round()}',
                    style: AppTextStyles.heading.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PrimaryButton(
                text: 'Continue',
                onPressed: () {
                  context.router.push(
                    BookingDetailsRoute(
                      roomData: room,
                      hotelName: widget.hotelName,
                      location: widget.location,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
