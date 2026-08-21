import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/explore/explore_screen.dart';
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExploreDestinationCard extends StatefulWidget {
  final ExploreDestination destination;

  const ExploreDestinationCard({super.key, required this.destination});

  @override
  State<ExploreDestinationCard> createState() => _ExploreDestinationCardState();
}

class _ExploreDestinationCardState extends State<ExploreDestinationCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          DestinationDetailsRoute(
            destination: DestinationModel(
              id: widget.destination.name.toLowerCase(),
              name: widget.destination.name,
              location: widget.destination.location,
              imageUrl: widget.destination.imageUrl,
              rating: widget.destination.rating,
            ),
          ),
        );
      },
      child: Container(
        height: AppSizes.exploreDestinationCardHeight,
        width: AppSizes.exploreDestinationCardWidth,
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
            // 1. Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radius16),
                child: CachedNetworkImage(
                  imageUrl: widget.destination.imageUrl,
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

            // 2. Gradient Overlay for text readability
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

            // 3. Heart/Favorite Icon
            Positioned(
              top: AppSizes.spacing12,
              right: AppSizes.spacing12,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  borderRadius: BorderRadius.circular(AppSizes.radius100),
                  child: Icon(
                    _isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_outlined,
                    size: AppSizes.icon14,
                    color: _isFavorite
                        ? AppColors.redColor
                        : AppColors.blackColor,
                  ),
                ),
              ),
            ),

            // 4. Details Overlay (Name, Location, Rating pill)
            Positioned(
              left: AppSizes.spacing12,
              bottom: AppSizes.spacing12,
              right: AppSizes.spacing12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.destination.name,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: AppSizes.icon14,
                      ),
                      const SizedBox(width: AppSizes.spacing2),
                      Expanded(
                        child: Text(
                          widget.destination.location,
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing8,
                      vertical: AppSizes.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(AppSizes.radius20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: AppSizes.icon14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          widget.destination.rating.toString(),
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
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
}
