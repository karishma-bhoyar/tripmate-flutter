import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';
import 'package:flutter_application_tripmate/features/favorites/data/favorite_store.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_bloc.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_event.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_state.dart';
import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';
import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';
import 'package:flutter_application_tripmate/widgets/main_layout.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';
import 'package:flutter_application_tripmate/widgets/common/shimmer_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const FetchFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppSizes.spacing24),
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                List<FavoriteModel> favorites = FavoriteStore.getAllFavorites();
                if (state is FavoritesLoaded) {
                  favorites = state.favorites;
                }

                if (state is FavoritesLoading && favorites.isEmpty) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) => const HotelCardSkeleton(),
                  );
                }

                if (favorites.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildFavoritesList(favorites);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('My Favorites', style: AppTextStyles.heading),
        const SizedBox(height: AppSizes.spacing4),
        Text(
          'Your saved destinations and hotels',
          style: AppTextStyles.caption.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.spacing24),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 64,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spacing24),
        Text(
          'No Favorites yet',
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSizes.spacing8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing24),
          child: Text(
            'Explore beautiful destinations and hotels to save them here.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(color: AppColors.greyColor),
          ),
        ),
        const SizedBox(height: AppSizes.spacing24),
        PrimaryButton(
          text: 'Explore Now',
          width: 200,
          onPressed: () {
            context.router.replace(const ExploreRoute());
          },
        ),
      ],
    );
  }

  Widget _buildFavoritesList(List<FavoriteModel> favorites) {
    return ListView.builder(
      itemCount: favorites.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final favorite = favorites[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.spacing16),
          child: InkWell(
            onTap: () {
              if (favorite.category.toLowerCase() == 'hotel') {
                final hotelData = HotelData(
                  id: favorite.id,
                  name: favorite.name,
                  location: favorite.location,
                  imageUrl: favorite.imageUrl,
                  rating: favorite.rating,
                  reviews: 120,
                  price: '₹12,000',
                );
                context.router.push(HotelDetailsRoute(hotelData: hotelData));
              } else {
                final destination = DestinationModel(
                  id: favorite.id,
                  name: favorite.name,
                  location: favorite.location,
                  imageUrl: favorite.imageUrl,
                  rating: favorite.rating,
                );
                context.router.push(
                  DestinationDetailsRoute(destination: destination),
                );
              }
            },
            borderRadius: BorderRadius.circular(AppSizes.radius16),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.spacing12),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppSizes.radius16),
                border: Border.all(
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radius12),
                    child: CachedNetworkImage(
                      imageUrl: favorite.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.greyColor.withValues(alpha: 0.1),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.spacing8,
                                vertical: AppSizes.spacing4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.08,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radius8,
                                ),
                              ),
                              child: Text(
                                favorite.category.toUpperCase(),
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<FavoritesBloc>()
                                    .add(RemoveFavoriteEvent(favorite.id));
                              },
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: AppColors.redColor,
                                size: AppSizes.icon20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spacing8),
                        Text(
                          favorite.name,
                          style: AppTextStyles.title.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
                              size: 14,
                            ),
                            const SizedBox(width: AppSizes.spacing2),
                            Expanded(
                              child: Text(
                                favorite.location,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.greyColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: AppSizes.spacing8),
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: AppSizes.spacing2),
                            Text(
                              favorite.rating.toString(),
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.bold,
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
          ),
        );
      },
    );
  }
}
