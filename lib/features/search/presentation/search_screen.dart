import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    // Automatically trigger initial search to show default destinations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchBloc>().add(PerformSearchEvent(''));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search destinations (e.g. Dubai, Paris)...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (query) {
            context.read<SearchBloc>().add(PerformSearchEvent(query));
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<SearchBloc>().add(PerformSearchEvent(''));
                setState(() {});
              },
            ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            if (state.destination.isEmpty) {
              return const Center(
                child: Text('No destinations found for your query'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.destination.length,
              itemBuilder: (context, index) {
                final destination = state.destination[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: destination.imageUrl,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.location_city),
                      ),
                    ),
                    title: Text(
                      destination.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(destination.location),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          destination.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Type to search destinations...'));
        },
      ),
    );
  }
}

