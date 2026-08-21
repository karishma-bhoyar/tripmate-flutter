import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';
import 'package:flutter_application_tripmate/widgets/common/section_header.dart';

class DestinationData {
  final String imageUrl;
  final String location;
  final String name;
  final double rating;

  const DestinationData({
    required this.imageUrl,
    required this.location,
    required this.name,
    required this.rating,
  });
}

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key});

  static const List<DestinationData> destinations = [
    DestinationData(
      imageUrl:
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=500&q=80',
      name: 'Bali',
      location: 'Indonesia',
      rating: 4.8,
    ),
    DestinationData(
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=500&q=80',
      name: 'Paris',
      location: 'France',
      rating: 4.7,
    ),
    DestinationData(
      imageUrl:
          'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=500&q=80',
      name: 'Tokyo',
      location: 'Japan',
      rating: 4.6,
    ),
    DestinationData(
      imageUrl:
          'https://images.unsplash.com/photo-1552832230-c0197dd311b5?auto=format&fit=crop&w=500&q=80',
      name: 'Rome',
      location: 'Italy',
      rating: 4.8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Popular Destinations",
          onSeeAllTap: () {},
        ),
        SizedBox(height: AppSizes.spacing16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: destinations.map((destination) {
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.spacing16),
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radius16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _DestinationCard(destination: destination),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final DestinationData destination;
  const _DestinationCard({required this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          DestinationDetailsRoute(
            destination: DestinationModel(
              id: destination.name.toLowerCase(),
              name: destination.name,
              location: destination.location,
              imageUrl: destination.imageUrl,
              rating: destination.rating,
            ),
          ),
        );
      },
      child: Container(
      width: AppSizes.destinationCardWidth,
      height: AppSizes.destinationCardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 1. Full Bleed Background Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radius16),
              child: CachedNetworkImage(
                imageUrl: destination.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Icon(Icons.image, color: AppColors.greyColor),
                ),
              ),
            ),
          ),
          // 2. Dark Gradient Overlay for Text Readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radius16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.75),
                  ],
                  stops: const [0.55, 1.0],
                ),
              ),
            ),
          ),
          // 3. Information Overlay (Location Pin & Star Rating)
          Positioned(
            left: AppSizes.spacing12,
            bottom: AppSizes.spacing12,
            right: AppSizes.spacing12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Location Row (e.g., "📍 Bali, Indonesia")
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.whiteColor,
                      size: AppSizes.icon14,
                    ),
                    const SizedBox(width: AppSizes.spacing4),
                    Expanded(
                      child: Text(
                        '${destination.name}, ${destination.location}',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacing4),
                // Rating Row (e.g., "⭐ 4.8")
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: AppSizes.icon14,
                    ),
                    const SizedBox(width: AppSizes.spacing4),
                    Text(
                      destination.rating.toString(),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
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
}
