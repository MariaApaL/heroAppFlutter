import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heroapp/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';


@immutable
class CloudFavorite {
  final String documentId;
  final String ownerUserId;
  final List<Map<String, dynamic>> superheroes;

  const CloudFavorite({
    required this.documentId,
    required this.ownerUserId,
    required this.superheroes,
  });

 CloudFavorite.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()?['ownerUserId'] as String,
        superheroes = List<Map<String, dynamic>>.from(
          snapshot.data()?['superheroes'] as List<dynamic>,
        );

  Map<String, dynamic> toJson() {
    return {
      'ownerUserId': ownerUserId,
      'superheroes': superheroes,
    };
  }
}