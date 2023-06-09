import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/api/api_service.dart';
import '../services/api/models/superhero_details_api_model.dart';
import '../services/auth/auth_service.dart';
import '../services/cloud/firebase_cloud_storage.dart';

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

 late final FirebaseCloudStorage _favoritesService;

@override
void initState() {
  _favoritesService = FirebaseCloudStorage();
  super.initState();
  _fetchSuperheroDetails();
  _checkFavoriteStatus();
}

 void _deleteFavorite() async {
    final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;
    final superheroId = widget.superheroId;

    await _favoritesService.deleteFavorite(
      ownerUserId: ownerUserId,
      superheroId: superheroId,
    );

    setState(() {
      _isFavorite = false;
    });

    // Call the onFavoriteRemoved callback
  }

  void _saveFavorite() async {
    final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;
    final superheroId = widget.superheroId;
    final superheroName = _superheroDetails!.name;

    await _favoritesService.addNewSuperhero(
      ownerUserId: ownerUserId,
      superheroId: superheroId,
      superheroName: superheroName,
    );

    setState(() {
      _isFavorite = true;
    });
  }
Future<void> _checkFavoriteStatus() async {
  final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;
    final superheroId = widget.superheroId;

    final favorite = await _favoritesService.isSuperheroFavorite(
      ownerUserId: ownerUserId,
      superheroId: superheroId,
    );

    setState(() {
      _isFavorite = favorite;
    });
}




void _fetchSuperheroDetails() async {
  try {
    final superheroDetails = await _apiService.getSuperheroDetails(widget.superheroId);
    setState(() {
      _superheroDetails = superheroDetails;
      _isLoading = false;
    });
  } catch (e) {
    // Manejar el error
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
          if (_superheroDetails != null)
            if (_superheroDetails!.appearance.gender.toLowerCase() == 'female')
              Icon(Icons.female,
                  color: Color.fromARGB(255, 251, 253,
                      251)) // Icono de female si es igual a 'female'
            else if (_superheroDetails!.appearance.gender.toLowerCase() ==
                'male')
              Icon(Icons.male,
                  color: Color.fromARGB(
                      255, 255, 255, 255)) // Icono de male si es igual a 'male'
            else
              Icon(Icons.help_outline,
                  color: Color.fromARGB(255, 255, 255,
                      255)) // Icono de interrogación en caso contrario
          else
            Icon(Icons.help_outline, color: Colors.green),
         IconButton(
  icon: Icon(
    _isFavorite ? Icons.favorite : Icons.favorite_border,
    color: _isFavorite ? Colors.red : Colors.white,
  ),
  onPressed: () {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      _saveFavorite();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Superhero added to favorites!'),
        ),
      );
    } else {
      _deleteFavorite();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Superhero removed from favorites!'),
        ),
      );
    }
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
                                height: size.height * 0.6,
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
                              margin: EdgeInsets.only(top: size.height * 0.5),
                              padding: const EdgeInsets.only(
                                // top: size.height * 0.13,
                                left: 16.0,
                                right: 16.0,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(width: size.width, height: 11.0),
                                  Text(
                                    _superheroDetails!.biography.fullName
                                                .isNotEmpty &&
                                            _superheroDetails!
                                                    .biography.fullName !=
                                                "null"
                                        ? _superheroDetails!.biography.fullName
                                        : 'Unknown',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 11.0),
                                  Text(
                                    _superheroDetails!
                                                .appearance.race.isNotEmpty &&
                                            _superheroDetails!
                                                    .appearance.race !=
                                                "null"
                                        ? _superheroDetails!.appearance.race
                                        : 'Unknown',
                                  ),
                                  const SizedBox(height: 11.0),
                                  Text(
                                    '${_superheroDetails!.biography.publisher.isNotEmpty && _superheroDetails!.biography.publisher != "null" ? _superheroDetails!.biography.publisher : 'Unknown'} ',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    _superheroDetails!.work.occupation.isNotEmpty ? _superheroDetails!.work.occupation : 'unknown',
                                  ),
                                  const SizedBox(
                                      height: 20.0), // Espacio adicional
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 30.0, // Tamaño del ícono
                                        height: 30.0, // Tamaño del ícono
                                        child: Icon(
                                          Icons.lightbulb_outline,
                                          color: Colors.blue, // Color del ícono
                                        ),
                                      ),
                                     const SizedBox(width: 8.0),
                                      Text(
                                        'Intelligence: ${_superheroDetails!.powerstats.intelligence.isEmpty && _superheroDetails!.powerstats.intelligence != "null" ? _superheroDetails!.powerstats.intelligence : 'Unknown'}',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                     const  SizedBox(
                                        width: 30.0, // Tamaño del ícono
                                        height: 30.0, // Tamaño del ícono
                                        child: Icon(
                                          Icons.fitness_center,
                                          color:
                                              Colors.green, // Color del ícono
                                        ),
                                      ),
                                   const    SizedBox(width: 8.0),
                                      Text(
                                        'Strength: ${_superheroDetails!.powerstats.strength.isNotEmpty && _superheroDetails!.powerstats.strength != "null" ? _superheroDetails!.powerstats.strength : 'Unknown'}',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                   const   SizedBox(
                                        width: 30.0, // Tamaño del ícono
                                        height: 30.0, // Tamaño del ícono
                                        child: Icon(
                                          Icons.speed,
                                          color:
                                              Colors.orange, // Color del ícono
                                        ),
                                      ),
                                     const SizedBox(width: 8.0),
                                      Text(
                                        'Speed: ${_superheroDetails!.powerstats.speed.isNotEmpty && _superheroDetails!.powerstats.speed != "null" ? _superheroDetails!.powerstats.speed : 'Unknown'}',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                     const SizedBox(
                                        width: 30.0, // Tamaño del ícono
                                        height: 30.0, // Tamaño del ícono
                                        child: Icon(
                                          Icons.security,
                                          color: Colors.red, // Color del ícono
                                        ),
                                      ),
                                     const SizedBox(width: 8.0),
                                      Text(
                                        'Durability: ${_superheroDetails!.powerstats.durability.isNotEmpty && _superheroDetails!.powerstats.durability != "null" ? _superheroDetails!.powerstats.durability : 'Unknown'}',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                     const SizedBox(
                                        width: 30.0, // Tamaño del ícono
                                        height: 30.0, // Tamaño del ícono
                                        child: Icon(
                                          Icons.flash_on,
                                          color:
                                              Colors.yellow, // Color del ícono
                                        ),
                                      ),
                                     const SizedBox(width: 8.0),
                                      Text(
                                        'Power: ${_superheroDetails!.powerstats.power.isNotEmpty && _superheroDetails!.powerstats.power != "null" ? _superheroDetails!.powerstats.power : 'Unknown'}',
                                      ),
                                    ],
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
