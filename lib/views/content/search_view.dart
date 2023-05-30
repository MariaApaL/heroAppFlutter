import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../services/api/api_service.dart';
import '../../services/api/models/superhero_api_model.dart';
import '../cards/superhero_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final SuperheroApiService _apiService = SuperheroApiService();
  bool _isLoading = false;
  List<SuperheroResponse> _superheroes = [];

  void _searchSuperheroes(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        SuperheroApiModel superheroData = await _apiService.getSuperhero(query);
        setState(() {
          _superheroes = superheroData.superheroes ?? [];
        });
      } catch (e) {
        // Handle error
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _superheroes = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchSuperheroes("a");
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
              onChanged: _searchSuperheroes,
              decoration: const InputDecoration(
                labelText: 'Search by superhero name',
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: !_isLoading,
              replacement:const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: _superheroes.length,
                itemBuilder: (context, index) {
                  SuperheroResponse superhero = _superheroes[index];
                  return SuperheroCard(superhero: superhero);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
