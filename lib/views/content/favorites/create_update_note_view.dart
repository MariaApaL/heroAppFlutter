import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/cloud/firebase_cloud_storage.dart';

// class CreateUpdateNoteView extends StatefulWidget {
//   final String ownerUserId;
//   final String superheroId;
//   final String superheroName;

//   const CreateUpdateNoteView({
//     Key? key,
//     required this.ownerUserId,
//     required this.superheroId,
//     required this.superheroName,
//   }) : super(key: key);

//   @override
//   _CreateUpdateNoteViewState createState() => _CreateUpdateNoteViewState();
// }

// class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
//   late final FirebaseCloudStorage _favoritesService;
//   late final TextEditingController _textController;

//   @override
//   void initState() {
//     _favoritesService = FirebaseCloudStorage();
//     _textController = TextEditingController();
//     super.initState();
//   }

//   void _saveFavorite() async {
//     final ownerUserId = widget.ownerUserId;
//     final superheroId = widget.superheroId;
//     final superheroName = widget.superheroName;
//     await _favoritesService.addFavorite(
//       ownerUserId: ownerUserId,
//       superheroId: superheroId,
//       superheroName: superheroName,
//     );
//   }

//   void _deleteFavorite() async {
//     final ownerUserId = widget.ownerUserId;
//     final superheroId = widget.superheroId;
//     await _favoritesService.deleteFavorite(
//       ownerUserId: ownerUserId,
//       superheroId: superheroId,
//     );
//   }

//   @override
//   void dispose() {
//     _deleteFavorite();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add to Favorites'),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               final ownerUserId = widget.ownerUserId;
//               final superheroId = widget.superheroId;
//               final superheroName = widget.superheroName;
//               await _favoritesService.addFavorite(
//                 ownerUserId: ownerUserId,
//                 superheroId: superheroId,
//                 superheroName: superheroName,
//               );
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.favorite),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Superhero: ${widget.superheroName}',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextField(
//               controller: _textController,
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               decoration: const InputDecoration(
//                 hintText: 'Add a note...',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }