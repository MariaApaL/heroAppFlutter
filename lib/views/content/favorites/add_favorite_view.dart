import 'package:flutter/material.dart';
import '../../../services/auth/auth_service.dart';
import '../../../services/cloud/firebase_cloud_storage.dart';

class AddFavoriteView extends StatefulWidget {
  final String ownerUserId;
  final String superheroId;
  final String superheroName;
  final FirebaseCloudStorage favoritesService;

  const AddFavoriteView({
    Key? key,
    required this.ownerUserId,
    required this.superheroId,
    required this.superheroName,
    required this.favoritesService,
  }) : super(key: key);

  @override
  State<AddFavoriteView> createState() => _AddFavoriteViewState();
}

class _AddFavoriteViewState extends State<AddFavoriteView> {
  void _saveFavorite() async {
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final superheroId = widget.superheroId;
    final superheroName = widget.superheroName;

    final newSuperheroFavorite = await widget.favoritesService.addNewSuperhero(
      ownerUserId: userId,
      superheroId: superheroId,
      superheroName: superheroName,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Superhero added to favorites!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Favorites'),
        actions: [
          IconButton(
            onPressed: _saveFavorite,
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Superhero: ${widget.superheroName}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}