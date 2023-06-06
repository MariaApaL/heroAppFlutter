import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../services/api/api_service.dart';
import '../../services/api/models/superhero_api_model.dart';
import '../../services/api/models/superhero_details_api_model.dart';
import '../../services/auth/auth_service.dart';
import '../../services/cloud/firebase_cloud_storage.dart';
import '../cards/superhero_card.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final TextEditingController _searchController = TextEditingController();
  final SuperheroApiService _apiService = SuperheroApiService();
  late final FirebaseCloudStorage _favoritesService = FirebaseCloudStorage();
  bool _isLoading = true;
  List<Map<String, dynamic>> _superheroes = [];
  List<Map<String, dynamic>> _filteredSuperheroes = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteSuperheroes();
  }

  void _searchSuperheroes(String query) {
    setState(() {
      _filteredSuperheroes = _superheroes.where((superhero) {
        final String name = superhero['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _loadFavoriteSuperheroes() async {
    final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;

    final favorites =
        await _favoritesService.getFavorites(ownerUserId: ownerUserId);

    List<String> superheroIds = [];
    favorites.forEach((favorite) {
      superheroIds.addAll(favorite.superheroes
          .map((superhero) => superhero['superheroId'] as String));
    });

    List<Future<SuperheroDetailsApiModel>> superheroDetailsFutures = [];
    for (String superheroId in superheroIds) {
      superheroDetailsFutures.add(_apiService.getSuperheroDetails(superheroId));
    }

    List<SuperheroDetailsApiModel> superheroDetailsList =
        await Future.wait(superheroDetailsFutures);

    setState(() {
      _superheroes = superheroDetailsList.map((superheroDetails) {
        return {
          'superheroId': superheroDetails.superheroId,
          'name': superheroDetails.name,
          'superheroImage': {
            'url': superheroDetails.image.url,
          },
        };
      }).toList();
      _filteredSuperheroes = _superheroes;
      _isLoading = false;
    });
  }

void _handleFavoriteRemoved(String superheroId) {
  setState(() {
    _filteredSuperheroes = _filteredSuperheroes.where((superhero) =>
        superhero['superheroId'] != superheroId).toList();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Superhero Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by superhero name',
              ),
              onChanged: _searchSuperheroes,
            ),
          ),
          Expanded(
            child: Visibility(
              visible: !_isLoading,
              replacement: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('No superheroes found'),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final superhero = _filteredSuperheroes[index];
                  final superheroId = superhero['superheroId'] as String?;
                  final name = superhero['name'] as String?;
                  final superheroImage =
                      superhero['superheroImage'] as Map<String, dynamic>?;

                  if (superheroId != null &&
                      name != null &&
                      superheroImage != null) {
                    return SuperheroCard(
                      superhero: SuperheroResponse(
                        superheroId: superheroId,
                        name: name,
                        superheroImage:
                            SuperheroImageResponse.fromJson(superheroImage),
                      ),
                      onFavoriteRemoved: () => _handleFavoriteRemoved(
                          superheroId), // Pass the superheroId to the callback
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
