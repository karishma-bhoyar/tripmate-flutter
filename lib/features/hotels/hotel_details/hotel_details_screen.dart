import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/favorites/data/favorite_store.dart';
import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';
import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';
import 'package:flutter_application_tripmate/widgets/common/section_header.dart';

@RoutePage()
class HotelDetailsScreen extends StatefulWidget {
  final HotelData? hotelData;
  const HotelDetailsScreen({super.key, this.hotelData});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  bool _isFavorite = false;
  bool _isExpanded = false;

  HotelData get hotelData =>
      widget.hotelData ??
      const HotelData(
        id: 'hotel_1',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=500&q=80',
        name: 'Grand Hyatt Regency',
        location: 'Goa, India',
        rating: 4.7,
        reviews: 120,
        price: '₹12,000',
      );

  @override
  void initState() {
    super.initState();
    _isFavorite = FavoriteStore.isFavorite(hotelData.id);
  }

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 160),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageHeader(context, imageHeight),
                  _buildTitlePriceSection(),
                  _buildQuikAmenitiesRow(),
                  _buildAboutSection(),
                  _buildAmenitiesList(),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, double height) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: hotelData.imageUrl,
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: height,
            color: AppColors.greyColor.withValues(alpha: 0.1),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: height,
            color: AppColors.greyColor.withValues(alpha: 0.1),
            child: const Icon(Icons.image, color: AppColors.greyColor),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.35),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSizes.spacing12,
          left: AppSizes.spacing24,
          right: AppSizes.spacing24,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircularButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => context.router.pop(),
              ),
              _buildCircularButton(
                icon: _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                iconColor: _isFavorite
                    ? AppColors.redColor
                    : AppColors.blackColor,
                // onTap: () {
                //   setState(() {
                //     _isFavorite = !_isFavorite;
                //   });
                // },
                onTap: () async {
                  final hotel = hotelData;
                  if (_isFavorite) {
                    await FavoriteStore.removeFavorite(hotel.id);
                  } else {
                    final favorite = FavoriteModel(
                      id: hotel.id,
                      name: hotel.name,
                      location: hotel.location,
                      imageUrl: hotel.imageUrl,
                      rating: hotel.rating,
                      category: "Hotel",
                    );
                    await FavoriteStore.addFavorite(favorite);
                  }
                  if (!mounted) return;
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacing12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: AppSizes.icon20,
          color: iconColor ?? AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildTitlePriceSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spacing24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelData.name,
                  style: AppTextStyles.heading.copyWith(fontSize: 24),
                ),
                const SizedBox(height: AppSizes.spacing8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.greyColor,
                      size: 16,
                    ),
                    const SizedBox(width: AppSizes.spacing4),
                    Expanded(
                      child: Text(
                        hotelData.location,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacing12),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: AppSizes.icon20,
                    ),
                    const SizedBox(width: AppSizes.spacing4),
                    Text(
                      hotelData.rating.toString(),
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacing4),
                    Expanded(
                      child: Text(
                        '(${hotelData.reviews} reviews)',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.greyColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.spacing16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                hotelData.price,
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                ),
              ),
              Text(
                '/night',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuikAmenitiesRow() {
    final amenities = [
      {"icon": Icons.wifi_rounded, "label": "Free Wi-Fi"},
      {"icon": Icons.restaurant_rounded, "label": "Breakfast"},
      {"icon": Icons.pool_rounded, 'label': 'Pool'},
      {'icon': Icons.local_parking_rounded, 'label': 'Parking'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: amenities.map((amenity) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSizes.radius16),
                ),
                child: Icon(
                  amenity['icon'] as IconData,
                  color: AppColors.primaryColor,
                  size: AppSizes.icon24,
                ),
              ),
              const SizedBox(height: AppSizes.spacing8),
              Text(
                amenity["label"].toString(),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAboutSection() {
    final text =
        'Surrounded by lush tropical greenery, ${hotelData.name} offers a peaceful retreat with valley views, stunning villas, and world-class hospitality. It is designed to blend perfectly with its natural surroundings while providing guests with luxurious comfort and unforgettable experiences.';
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Hotel',
            style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.spacing8),
          Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: AppColors.greyColor,
              height: 1.5,
            ),
            maxLines: _isExpanded ? null : 3,
            overflow: _isExpanded
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Read Less' : 'Read More...',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesList() {
    final detailedAmenities = [
      {'icon': Icons.pool_rounded, 'name': 'Swimming Pool'},
      {'icon': Icons.wifi_rounded, 'name': 'Free Wi-Fi'},
      {'icon': Icons.spa_rounded, 'name': 'Spa & Wellness'},
      {'icon': Icons.fitness_center_rounded, 'name': 'Gym & Fitness'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Amenities',
            onSeeAllTap: () {},
          ),
          // const SizedBox(height: AppSizes.spacing8),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSizes.spacing12,
              crossAxisSpacing: AppSizes.spacing12,
              childAspectRatio: 3.5,
            ),
            itemCount: detailedAmenities.length,
            itemBuilder: (context, index) {
              final amenity = detailedAmenities[index];
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacing12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(AppSizes.radius12),
                  border: Border.all(
                    color: AppColors.greyColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      amenity['icon'] as IconData,
                      color: AppColors.primaryColor,
                      size: AppSizes.icon20,
                    ),
                    const SizedBox(width: AppSizes.spacing8),
                    Expanded(
                      child: Text(
                        amenity["name"].toString(),
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
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
          text: 'Select Room',
          onPressed: () {
            context.router.push(
              SelectRoomRoute(
                hotelName: hotelData.name,
                location: hotelData.location,
              ),
            );
          },
        ),
      ),
    );
  }
}
