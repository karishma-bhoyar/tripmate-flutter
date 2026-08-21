import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';

import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';
import 'package:flutter_application_tripmate/widgets/common/section_header.dart';

@RoutePage()
class DestinationDetailsScreen extends StatelessWidget {
  final DestinationModel? _passedDestination;

  const DestinationDetailsScreen({super.key, DestinationModel? destination})
      : _passedDestination = destination;

  DestinationModel get destination =>
      _passedDestination ??
      const DestinationModel(
        id: '1',
        imageUrl:
            'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=500&q=80',
        name: 'Bali',
        location: 'Indonesia',
        rating: 4.8,
      );

  @override
  Widget build(BuildContext context) {
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
                  _buildImageHeader(context),
                  _buildDetailsSection(),
                  _buildPopularHotels(),
                  _buildThingsToDo(),
                  const SizedBox(height: AppSizes.spacing24),
                  _buildTravelTips(),
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

  Widget _buildImageHeader(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.45;
    return Stack(
      children: [
        Container(
          height: imageHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(destination.imageUrl),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: .3),
                  Colors.transparent,
                  Colors.black.withValues(alpha: .4),
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
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () async {
                  final popped = await context.router.maybePop();
                  if (!popped && context.mounted) {
                    context.router.replaceAll([const HomeRoute()]);
                  }
                },
              ),
              _buildCircularButton(
                icon: Icons.favorite_border_rounded,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Name & Location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: AppTextStyles.heading.copyWith(fontSize: 24),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.spacing4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.greyColor,
                          size: 16,
                        ),
                        const SizedBox(width: AppSizes.spacing4),
                        Expanded(
                          child: Text(
                            destination.location,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.greyColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.spacing16),
              // Right Column: Rating & Reviews Count
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: AppSizes.spacing4),
                      Text(
                        destination.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '(3,240 reviews)',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.greyColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacing24),
          _buildQuickInfoGrid(),
          const SizedBox(height: AppSizes.spacing24),
          Text(
            'About ${destination.name}',
            style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.spacing8),
          Text(
            '${destination.name} is a tropical paradise known for its beautiful beaches, rich culture, lush rice terraces, and vibrant nightlife. Whether you\'re seeking adventure, relaxation, or spiritual healing, ${destination.name} has something for every traveler.,',
            style: AppTextStyles.body.copyWith(
              color: AppColors.greyColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoGrid() {
    final infoItems = [
      {
        "label": "Best Time",
        "value": "Apr - Oct",
        "icon": Icons.calendar_today_rounded,
      },
      {
        "label": "Time Zone",
        "value": "GMT +8",
        "icon": Icons.access_time_rounded,
      },
      {
        "label": "Currency",
        "value": "IDR (Rp)",
        "icon": Icons.credit_card_rounded,
      },
      {
        "label": "Language",
        "value": "Indonesian",
        "icon": Icons.translate_rounded,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: infoItems.map((item) {
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circular Icon Container
              Container(
                padding: const EdgeInsets.all(AppSizes.spacing12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: AppColors.primaryColor,
                  size: AppSizes.icon20,
                ),
              ),
              const SizedBox(height: AppSizes.spacing8),
              // Label (Best Time, Currency, etc.)
              Text(
                item["label"] as String,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.greyColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacing2),
              // Value (Apr - Oct, IDR (Rp), etc.)
              Text(
                item["value"] as String,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopularHotels() {
    final mockHotels = [
      {
        "name": "The Kayon Resort",
        "location": "Ubud, Bali",
        "rating": 4.7,
        "price": "₹18,500",
        "imageUrl":
            "https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=500&q=80",
      },
      {
        "name": "Ayana Resort",
        "location": "Jimbaran, Bali",
        "rating": 4.8,
        "price": "₹22,000",
        "imageUrl":
            "https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=500&q=80",
      },
      {
        "name": "Potato Head Suites",
        "location": "Seminyak, Bali",
        "rating": 4.5,
        "price": "₹15,000",
        "imageUrl":
            "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=500&q=80",
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Popular Hotels',
            onSeeAllTap: () {},
          ),
          const SizedBox(height: AppSizes.spacing16),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mockHotels.length,

              itemBuilder: (context, index) {
                final hotel = mockHotels[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: AppSizes.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(AppSizes.radius16),
                    border: Border.all(
                      color: AppColors.greyColor.withValues(alpha: .1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(AppSizes.radius16),
                            ),
                            child: CachedNetworkImage(
                              height: 110,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: hotel["imageUrl"].toString(),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.whiteColor,
                              child: Icon(
                                Icons.favorite_border_rounded,
                                size: 14,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSizes.spacing8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel["name"].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hotel["location"] as String,
                              style: const TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacing8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                      size: 12,
                                    ),

                                    const SizedBox(width: 2),
                                    Text(
                                      hotel["rating"].toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: hotel["price"].toString(),
                                        style: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '/night',
                                        style: TextStyle(
                                          color: AppColors.greyColor,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
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
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThingsToDo() {
    final activities = [
      {
        "title": "Explore Beaches",
        "imageUrl":
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=400&q=80",
      },
      {
        "title": "Water Sports",
        "imageUrl":
            "https://images.unsplash.com/photo-1502680390469-be75c86b636f?auto=format&fit=crop&w=400&q=80",
      },
      {
        "title": "Temple Tour",
        "imageUrl":
            "https://images.unsplash.com/photo-1544644181-1484b3fdfc62?auto=format&fit=crop&w=400&q=80",
      },
      {
        "title": "Rice Terraces",
        "imageUrl":
            "https://images.unsplash.com/photo-1565945887714-d2e39c580dbb?auto=format&fit=crop&w=400&q=80",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: "Top Things To Do",
            onSeeAllTap: () {},
          ),
          const SizedBox(height: AppSizes.spacing16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: AppSizes.spacing12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radius12),
                        child: CachedNetworkImage(
                          imageUrl: activity["imageUrl"]!,
                          height: 80,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 80,
                            width: 100,
                            color: AppColors.greyColor.withValues(alpha: 0.1),
                            child: Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,

                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 80,
                            width: 100,
                            color: AppColors.greyColor.withValues(alpha: 0.1),
                            child: const Icon(
                              Icons.image_not_supported_rounded,
                              color: AppColors.greyColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        activity["title"]!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelTips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing24),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacing16),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(
            alpha: 0.05,
          ), // Soft blue background
          borderRadius: BorderRadius.circular(AppSizes.radius16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular Lightbulb Icon
            Container(
              padding: const EdgeInsets.all(AppSizes.spacing8),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lightbulb_outline_rounded,
                color: AppColors.primaryColor,
                size: AppSizes.icon20,
              ),
            ),
            const SizedBox(width: AppSizes.spacing16),

            // Tips Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Travel Tips',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing4),
                  Text(
                    'Carry light clothes, sunscreen, and cash. Respect local traditions and dress modestly when visiting temples.',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.greyColor,
                      height: 1.4,
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
          text: 'Explore Hotels',
          onPressed: () {
            context.router.push(HotelListRoute(destination: destination));
          },
        ),
      ),
    );
  }
}

Widget _buildCircularButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(AppSizes.spacing12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: AppSizes.icon18, color: AppColors.blackColor),
    ),
  );
}
