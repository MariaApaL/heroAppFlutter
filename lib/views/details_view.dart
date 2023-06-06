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
  bool _isFavorite = false; // Agregado: estado para el botón de corazón
  final SuperheroApiService _apiService = SuperheroApiService();

  @override
  void initState() {
    super.initState();
    _fetchSuperheroDetails();
  }

  void _fetchSuperheroDetails() async {
    try {
      final superheroDetails =
          await _apiService.getSuperheroDetails(widget.superheroId);
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(215, 157, 30, 30),
        elevation: 0,
        title: Center(
          child: Text(
            _superheroDetails != null
                ? _superheroDetails!.name
                : 'Superhero Details',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          _superheroDetails != null &&
                  _superheroDetails!.biography.publisher.toLowerCase() ==
                      'marvel'
              ? Icon(Icons.check_circle, color: Colors.green)
              : Icon(Icons.clear, color: Colors.red),
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _superheroDetails != null
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                width: size.width,
                                height: size.height * 0.5,
                                child: SizedBox(
                                  width: size.width,
                                  child: Image.network(
                                    _superheroDetails!.image.url,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: size.height * 0.4),
                              padding: const EdgeInsets.only(
                                // top: size.height * 0.13,
                                left: 16.0,
                                right: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(width: size.width, height: 16.0),
                                  Text(
                                    _superheroDetails!
                                            .biography.fullName.isNotEmpty && _superheroDetails!.biography.fullName != "null"
                                        ? _superheroDetails!.biography.fullName
                                        : 'Unknown',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Intelligence: ${_superheroDetails!.powerstats.intelligence.isEmpty && _superheroDetails!.powerstats.intelligence != "null" ? _superheroDetails!.powerstats.intelligence : 'Unknown'}',
                                  ),
                                  Text(
                                    'Strength: ${_superheroDetails!.powerstats.strength.isNotEmpty && _superheroDetails!.powerstats.strength != "null" ? _superheroDetails!.powerstats.strength : 'Unknown'}',
                                  ),
                                  Text(
                                    'Speed: ${_superheroDetails!.powerstats.speed.isNotEmpty && _superheroDetails!.powerstats.speed != "null" ? _superheroDetails!.powerstats.speed : 'Unknown'}',
                                  ),
                                  Text(
                                    'Durability: ${_superheroDetails!.powerstats.durability.isNotEmpty && _superheroDetails!.powerstats.durability != "null" ? _superheroDetails!.powerstats.durability : 'Unknown'}',
                                  ),
                                  Text(
                                    'Power: ${_superheroDetails!.powerstats.power.isNotEmpty && _superheroDetails!.powerstats.power != "null" ? _superheroDetails!.powerstats.power : 'Unknown'}',
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Publisher: ${_superheroDetails!.biography.publisher.isNotEmpty && _superheroDetails!.biography.publisher != "null" ? _superheroDetails!.biography.publisher : 'Unknown'}',
                                  ),
                                  Text(
                                    'First Appearance: ${_superheroDetails!.biography.firstAppearance.isNotEmpty && _superheroDetails!.biography.firstAppearance != "null" ? _superheroDetails!.biography.firstAppearance : 'Unknown'}',
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Gender: ${_superheroDetails!.appearance.gender.isNotEmpty && _superheroDetails!.appearance.gender!="null" ? _superheroDetails!.appearance.gender : 'Unknown'}',
                                  ),
                                  Text(
                                    'Race: ${_superheroDetails!.appearance.race.isNotEmpty && _superheroDetails!.appearance.race!="null" ? _superheroDetails!.appearance.race: 'Unknown'}',
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Occupation: ${_superheroDetails!.work.occupation.isNotEmpty ? _superheroDetails!.work.occupation : 'unknown'}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
