import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/favorites/data/favorite_store.dart';
import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';

class HotelData {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final double rating;
  final int reviews;
  final String price;

  const HotelData({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.id,
  });
}

class HotelCard extends StatefulWidget {
  final HotelData hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
    _isFavorite = FavoriteStore.isFavorite(widget.hotel.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(HotelDetailsRoute(hotelData: widget.hotel));
      },

      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacing8),
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
            // 1. Hotel Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              child: CachedNetworkImage(
                imageUrl: widget.hotel.imageUrl,
                height: AppSizes.spacing100,
                width: AppSizes.spacing100,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: AppSizes.spacing100,
                  width: AppSizes.spacing100,
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: AppSizes.spacing100,
                  width: AppSizes.spacing100,
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  child: const Icon(Icons.image, color: AppColors.greyColor),
                ),
              ),
            ),

            const SizedBox(width: AppSizes.spacing12),

            // 2. Hotel Details (Wrapped in Expanded to define width constraints)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotel.name,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spacing4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.greyColor,
                        size: AppSizes.icon14,
                      ),
                      const SizedBox(width: AppSizes.spacing4),
                      Expanded(
                        child: Text(
                          widget.hotel.location,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.greyColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: AppSizes.icon18,
                      ),
                      const SizedBox(width: AppSizes.spacing4),
                      Text(
                        widget.hotel.rating.toString(),
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacing4),
                      Text(
                        ' • ${widget.hotel.reviews} reviews',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSizes.spacing8),

            // 3. Price & Favorite Button Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    if (_isFavorite) {
                      await FavoriteStore.removeFavorite(widget.hotel.id);
                    } else {
                      final favorite = FavoriteModel(
                        id: widget.hotel.id,
                        name: widget.hotel.name,
                        location: widget.hotel.location,
                        imageUrl: widget.hotel.imageUrl,
                        rating: widget.hotel.rating,
                        category: "Hotel",
                      );
                      await FavoriteStore.addFavorite(favorite);
                    }
                    if (!mounted) return;
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    _isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: _isFavorite
                        ? AppColors.redColor
                        : AppColors.greyColor,
                    size: AppSizes.icon24,
                  ),
                ),
                const SizedBox(height: AppSizes.spacing20),
                Text(
                  widget.hotel.price,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/ night',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
