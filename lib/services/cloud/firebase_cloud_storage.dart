import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloud_favorite.dart';
import 'cloud_storage_constants.dart';
import 'cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final favorites = FirebaseFirestore.instance.collection('favorites');

 Future<void> deleteFavorite({required String ownerUserId, required String superheroId}) async {
  try {
    final favoriteSnapshot = await favorites
        .where('ownerUserId', isEqualTo: ownerUserId)
        .limit(1)
        .get();

    if (favoriteSnapshot.docs.isNotEmpty) {
      final favoriteDoc = favoriteSnapshot.docs.first;
      final superheroes = favoriteDoc.data()['superheroes'] as List<dynamic>;

      final updatedSuperheroes = superheroes.where((superhero) {
        return superhero['superheroId'] != superheroId;
      }).toList();

      await favoriteDoc.reference.update({'superheroes': updatedSuperheroes});
    }
  } catch (e) {
    throw CouldNotDeleteSuperheroException();
  }
}

  Future<bool> isSuperheroFavorite({
  required String ownerUserId,
  required String superheroId,
}) async {
  try {
    final favoriteSnapshot = await favorites
        .where('ownerUserId', isEqualTo: ownerUserId)
        .limit(1)
        .get();

    if (favoriteSnapshot.docs.isNotEmpty) {
      final favoriteDoc = favoriteSnapshot.docs.first;
      final superheroes = favoriteDoc.data()['superheroes'] as List<dynamic>;

      final exists = superheroes.any((superhero) {
        return superhero['superheroId'] == superheroId;
      });

      return exists;
    }

    return false;
  } catch (e) {
    throw CouldNotCheckFavSuperheroException();
  }
}

  Stream<Iterable<CloudFavorite>> allSuperheros({required String ownerUserId}) {
    final allSuperheros = favorites
        .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudFavorite.fromSnapshot(doc)));
    return allSuperheros;
  }

Future<void> addNewSuperhero({
  required String ownerUserId,
  required String superheroId,
  required String superheroName,
}) async {
  try {
    final favoriteSnapshot = await favorites
        .where('ownerUserId', isEqualTo: ownerUserId)
        .limit(1)
        .get();

    if (favoriteSnapshot.docs.isNotEmpty) {
      final favoriteDoc = favoriteSnapshot.docs.first;
      final favoriteId = favoriteDoc.id;

      final existingSuperheroes = favoriteDoc.data()['superheroes'] as List<dynamic>;
      final updatedSuperheroes = [
        ...existingSuperheroes,
        {'superheroId': superheroId, 'superheroName': superheroName},
      ];

      await favorites.doc(favoriteId).update({'superheroes': updatedSuperheroes});
    } else {
      await favorites.add({
        'ownerUserId': ownerUserId,
        'superheroes': [
          {'superheroId': superheroId, 'superheroName': superheroName},
        ],
      });
    }
  } catch (e) {
    throw CouldNotAddSuperheroException();
  }
}

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}