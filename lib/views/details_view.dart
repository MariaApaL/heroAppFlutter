

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/api/api_service.dart';
import '../services/api/models/superhero_details_api_model.dart';

class DetailsView extends StatefulWidget {
  final String superheroId;

  const DetailsView({Key? key, required this.superheroId}) : super(key: key);

  @override
   State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  SuperheroDetailsApiModel? _superheroDetails;
  bool _isLoading = true;
  final SuperheroApiService _apiService = SuperheroApiService();

  @override
  void initState() {
    super.initState();
    _fetchSuperheroDetails();
  }

  void _fetchSuperheroDetails() async {
    try {
      final superheroDetails = await _apiService.getSuperheroDetails(widget.superheroId);
      setState(() {
        _superheroDetails = superheroDetails;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Superhero Details'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _superheroDetails != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          _superheroDetails!.image.url,
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Name: ${_superheroDetails!.name}',
                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Intelligence: ${_superheroDetails!.powerstats.intelligence}',
                      ),
                      Text(
                        'Strength: ${_superheroDetails!.powerstats.strength}',
                      ),
                      Text(
                        'Speed: ${_superheroDetails!.powerstats.speed}',
                      ),
                      Text(
                        'Durability: ${_superheroDetails!.powerstats.durability}',
                      ),
                      Text(
                        'Power: ${_superheroDetails!.powerstats.power}',
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Full Name: ${_superheroDetails!.biography.fullName}',
                      ),
                      Text(
                        'Publisher: ${_superheroDetails!.biography.publisher}',
                      ),
                      Text(
                        'First Appearance: ${_superheroDetails!.biography.firstAppearance}',
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Gender: ${_superheroDetails!.appearance.gender}',
                      ),
                      Text(
                        'Race: ${_superheroDetails!.appearance.race}',
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Occupation: ${_superheroDetails!.work.occupation}',
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text('Failed to fetch superhero details'),
                ),
    );
  }
}