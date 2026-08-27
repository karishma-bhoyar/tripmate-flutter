import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_bloc.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_event.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchBloc>().add(PerformSearchEvent(''));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<SearchBloc>().add(PerformSearchEvent(''));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.blackColor, size: 20),
          onPressed: () => context.router.pop(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: AppTextStyles.body.copyWith(fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Search destinations (e.g. Bali, Paris)...',
            border: InputBorder.none,
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.greyColor,
              fontSize: 15,
            ),
          ),
          onChanged: (query) {
            context.read<SearchBloc>().add(PerformSearchEvent(query));
            setState(() {});
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close_rounded, color: AppColors.greyColor),
              onPressed: _clearSearch,
            ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is SearchLoaded) {
            if (state.destination.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.spacing24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.spacing20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacing16),
                      Text(
                        'No destinations found',
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: AppSizes.spacing8),
                      Text(
                        'We couldn\'t find any match for "${_searchController.text}". Try searching another keyword.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption.copyWith(fontSize: 13),
                      ),
                      const SizedBox(height: AppSizes.spacing20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSizes.radius12),
                          ),
                        ),
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.refresh_rounded, size: 18),
                        label: const Text('Clear Search'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppSizes.spacing16),
              itemCount: state.destination.length,
              itemBuilder: (context, index) {
                final destination = state.destination[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.spacing12),
                  child: Material(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(AppSizes.radius16),
                    elevation: 1,
                    shadowColor: AppColors.blackColor.withValues(alpha: 0.05),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppSizes.radius16),
                      onTap: () {
                        context.router.push(
                          DestinationDetailsRoute(destination: destination),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.spacing12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radius12),
                              child: CachedNetworkImage(
                                imageUrl: destination.imageUrl,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  height: 60,
                                  width: 60,
                                  color: AppColors.greyColor
                                      .withValues(alpha: 0.1),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 60,
                                  width: 60,
                                  color: AppColors.greyColor
                                      .withValues(alpha: 0.1),
                                  child: const Icon(
                                    Icons.landscape_rounded,
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
                                    destination.name,
                                    style: AppTextStyles.title.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.spacing4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 14,
                                        color: AppColors.greyColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        destination.location,
                                        style: AppTextStyles.caption,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  destination.rating.toString(),
                                  style: AppTextStyles.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is SearchError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.body.copyWith(color: AppColors.redColor),
              ),
            );
          }
          return Center(
            child: Text(
              'Type to search destinations...',
              style: AppTextStyles.caption,
            ),
          );
        },
      ),
    );
  }
}


