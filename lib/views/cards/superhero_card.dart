import 'package:flutter/material.dart';
import 'package:heroapp/constants/routes.dart';

import '../../services/api/models/superhero_api_model.dart';
import '../../services/auth/auth_service.dart';
import '../../services/cloud/firebase_cloud_storage.dart';
import '../details_view.dart';

import 'package:flutter/material.dart';

import '../details_view.dart';

class SuperheroCard extends StatefulWidget {
  final SuperheroResponse superhero;
  final VoidCallback onFavoriteRemoved; // Add this line

  const SuperheroCard({
    super.key,
    required this.superhero,
    required this.onFavoriteRemoved, // Add this line
  });

  @override
  State<SuperheroCard> createState() => _SuperheroCardState();
}

class _SuperheroCardState extends State<SuperheroCard> {
  late final FirebaseCloudStorage _favoritesService;
  bool isFavorite = false;

  @override
  void initState() {
    _favoritesService = FirebaseCloudStorage();
    _checkFavoriteStatus();
    super.initState();
  }

  Future<void> _checkFavoriteStatus() async {
    final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;
    final superheroId = widget.superhero.superheroId;

    final favorite = await _favoritesService.isSuperheroFavorite(
      ownerUserId: ownerUserId,
      superheroId: superheroId,
    );

    setState(() {
      isFavorite = favorite;
    });
  }

  void _deleteFavorite() async {
    final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;
    final superheroId = widget.superhero.superheroId;

    await _favoritesService.deleteFavorite(
      ownerUserId: ownerUserId,
      superheroId: superheroId,
    );

    setState(() {
      isFavorite = false;
    });

    widget.onFavoriteRemoved(); // Call the onFavoriteRemoved callback
  }

  void _saveFavorite() async {
    final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;
    final superheroId = widget.superhero.superheroId;
    final superheroName = widget.superhero.name;

    await _favoritesService.addNewSuperhero(
      ownerUserId: ownerUserId,
      superheroId: superheroId,
      superheroName: superheroName,
    );

    setState(() {
      isFavorite = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailsView(superheroId: widget.superhero.superheroId),
          ),
        );
      },
      child: SizedBox(
        // Establece la altura deseada para la tarjeta
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(40.0),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      widget.superhero.superheroImage.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.superhero.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            _deleteFavorite();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Superhero removed from favorites!'),
                              ),
                            );
                          } else {
                            _saveFavorite();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Superhero added to favorites!'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
