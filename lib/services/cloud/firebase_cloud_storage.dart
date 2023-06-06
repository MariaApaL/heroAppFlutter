import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloud_favorite.dart';
import 'cloud_storage_constants.dart';
import 'cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final favorites = FirebaseFirestore.instance.collection('favorites');


//Para listar los favoritos
Future<List<CloudFavorite>> getFavorites({required String ownerUserId}) async {
  // Obtiene una referencia a la colección 'favorites' en Firestore
  final favoritesCollection = FirebaseFirestore.instance.collection('favorites');

  // Realiza una consulta a Firestore para obtener los documentos que tienen 'ownerUserId' igual a 'ownerUserId'
  final querySnapshot = await favoritesCollection.where('ownerUserId', isEqualTo: ownerUserId).get();
  
  // Crea una lista vacía para almacenar los favoritos
  List<CloudFavorite> favorites = [];

  // Recorre cada documento devuelto por la consulta
  for (var doc in querySnapshot.docs) {
    // crea una copia del documento y lo guarda en favorites
    favorites.add(CloudFavorite.fromSnapshot(doc));
  }
  return favorites;
}


Future<void> deleteFavorite({required String ownerUserId, required String superheroId}) async {
  try {
    // Realiza una consulta para obtener el favorito correspondiente al ownerUserId especificado
    final favoriteSnapshot = await favorites
        .where('ownerUserId', isEqualTo: ownerUserId)
        .limit(1)
        .get();

    // Verifica si se encontró un favorito
    if (favoriteSnapshot.docs.isNotEmpty) {
      final favoriteDoc = favoriteSnapshot.docs.first;
      final superheroes = favoriteDoc.data()['superheroes'] as List<dynamic>;

      // Filtra la lista de superhéroes para eliminar el que coincida con superheroId
      final updatedSuperheroes = superheroes.where((superhero) {
        return superhero['superheroId'] != superheroId;
      }).toList();

      // Actualiza el documento de favorito en Firestore con la lista actualizada de superhéroes
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
    // Realiza una consulta para obtener el favorito correspondiente al ownerUserId especificado
    final favoriteSnapshot = await favorites
        .where('ownerUserId', isEqualTo: ownerUserId)
        .limit(1)
        .get();

    // Verifica si se encontró un favorito
    if (favoriteSnapshot.docs.isNotEmpty) {
      final favoriteDoc = favoriteSnapshot.docs.first;
      final superheroes = favoriteDoc.data()['superheroes'] as List<dynamic>;

      // Verifica si existe un superhéroe con superheroId en la lista de superhéroes del favorito
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
  // Obtiene un stream de todos los favoritos correspondientes al ownerUserId especificado
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
    // Realiza una consulta para obtener el favorito correspondiente al ownerUserId especificado
    final favoriteSnapshot = await favorites
        .where('ownerUserId', isEqualTo: ownerUserId)
        .limit(1)
        .get();

    // Verifica si se encontró un favorito
    if (favoriteSnapshot.docs.isNotEmpty) {
      final favoriteDoc = favoriteSnapshot.docs.first;
      final favoriteId = favoriteDoc.id;

      final existingSuperheroes = favoriteDoc.data()['superheroes'] as List<dynamic>;
      
      // Crea una nueva lista de superhéroes agregando el nuevo superhéroe al final
      final updatedSuperheroes = [
        ...existingSuperheroes,
        {'superheroId': superheroId, 'superheroName': superheroName},
      ];

      // Actualiza el documento de favorito en Firestore con la lista actualizada de superhéroes
      await favorites.doc(favoriteId).update({'superheroes': updatedSuperheroes});
    } else {
      // Crea un nuevo documento de favorito en Firestore con el ownerUserId y la lista de superhéroes
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