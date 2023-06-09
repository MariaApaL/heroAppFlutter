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

  Widget build(BuildContext context) {
    int _current = 0;

    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color:const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color:const Color.fromARGB(255, 132, 114, 114),
              width: 2.0,
            ),
          ),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsView(
                      superheroId: widget.superhero.superheroId.toString(),
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    height: 320,
                    margin: const EdgeInsets.only(top: 30),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      widget.superhero.superheroImage.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.superhero.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });

                                if (isFavorite) {
                                  _saveFavorite();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Superhero added to favorites!'),
                                    ),
                                  );
                                } else {
                                  _deleteFavorite();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Superhero removed from favorites!'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
