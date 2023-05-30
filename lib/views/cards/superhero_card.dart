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

  const SuperheroCard({Key? key, required this.superhero}) : super(key: key);

  @override
  State<SuperheroCard> createState() => _SuperheroCardState();
}

class _SuperheroCardState extends State<SuperheroCard> {
  late final FirebaseCloudStorage _favoritesService;
  bool isFavorite = false;

  @override
  void initState() {
    _favoritesService = FirebaseCloudStorage();
    super.initState();
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
      isFavorite = true; // Actualizamos el estado a true
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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  widget.superhero.superheroImage.url,
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.superhero.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    if (isFavorite) {
                      _deleteFavorite();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Superhero removed from favorites!')),
                      );
                    } else {
                      _saveFavorite();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Superhero added to favorites!')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
