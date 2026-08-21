import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_bloc.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_event.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_state.dart';
import 'package:flutter_application_tripmate/view/auth/widget/custom_terxtfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        showOverlay();
      }
    });
  }

  @override
  void dispose() {
    _hideOverlay();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void showOverlay() {
    if (_overlayEntry != null) return;
    context.read<SearchBloc>().add(PerformSearchEvent(_searchController.text));
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
      builder: (overlayContext) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _focusNode.unfocus();
                _hideOverlay();
              },
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0.0, size.height + 8.0),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(AppSizes.radius16),
                color: AppColors.whiteColor,
                shadowColor: Colors.black26,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 280),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.radius16),
                    color: AppColors.whiteColor,
                  ),
                  child: BlocBuilder<SearchBloc, SearchState>(
                    bloc: context.read<SearchBloc>(),
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      } else if (state is SearchLoaded) {
                        if (state.destination.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                'No destinations found',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shrinkWrap: true,
                          itemCount: state.destination.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.black12,
                          ),
                          itemBuilder: (context, index) {
                            final destination = state.destination[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              leading: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radius8),
                                child: CachedNetworkImage(
                                  imageUrl: destination.imageUrl,
                                  height: 44,
                                  width: 44,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.location_city,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              title: Text(
                                destination.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                destination.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    destination.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                final nav = AutoRouter.of(this.context);
                                _searchController.clear();
                                _focusNode.unfocus();
                                _hideOverlay();
                                nav.push(
                                  DestinationDetailsRoute(destination: destination),
                                );
                              },
                            );
                          },
                        );
                      } else if (state is SearchError) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(child: Text(state.message)),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            'Type to search destinations...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: CustomTextField(
        focusNode: _focusNode,
        controller: _searchController,
        hintText: 'Search destination, hotels, flights...',
        prefixIcon: Icons.search,
        onChanged: (value) {
          if (_overlayEntry == null) {
            showOverlay();
          }
          context.read<SearchBloc>().add(PerformSearchEvent(value));
        },
        suffixIcon: IconButton(
          icon: Icon(
            _searchController.text.isNotEmpty
                ? Icons.clear
                : Icons.filter_list,
            color: AppColors.primaryColor,
            size: AppSizes.icon20,
          ),
          onPressed: () {
            if (_searchController.text.isNotEmpty) {
              _searchController.clear();
              context.read<SearchBloc>().add(PerformSearchEvent(''));
              setState(() {});
            }
          },
        ),
      ),
    );
  }
}
