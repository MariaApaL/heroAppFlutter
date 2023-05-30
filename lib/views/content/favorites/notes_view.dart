// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

// class NotesView extends StatefulWidget {
//   const NotesView({Key? key}) : super(key: key);

//   @override
//   _NotesViewState createState() => _NotesViewState();
// }

// class _NotesViewState extends State<NotesView> {
//   late final FirebaseCloudStorage _notesService;
//   String get userId => AuthService.firebase().currentUser!.id;

//   @override
//   void initState() {
//     _notesService = FirebaseCloudStorage();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Notes'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
//             },
//             icon: const Icon(Icons.add),
//           ),
//           PopupMenuButton<MenuAction>(
//             onSelected: (value) async {
//               switch (value) {
//                 case MenuAction.logout:
//                   final shouldLogout = await showLogOutDialog(context);
//                   if (shouldLogout) {
//                     context.read<AuthBloc>().add(
//                           const AuthEventLogOut(),
//                         );
//                   }
//               }
//             },
//             itemBuilder: (context) {
//               return const [
//                 PopupMenuItem<MenuAction>(
//                   value: MenuAction.logout,
//                   child: Text('Log out'),
//                 ),
//               ];
//             },
//           )
//         ],
//       ),
//       body: StreamBuilder(
//         stream: _notesService.allNotes(ownerUserId: userId),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//             case ConnectionState.active:
//               if (snapshot.hasData) {
//                 final allNotes = snapshot.data as Iterable<CloudNote>;
//                 return NotesListView(
//                   notes: allNotes,
//                   onDeleteNote: (note) async {
//                     await _notesService.deleteNote(documentId: note.documentId);
//                   },
//                   onTap: (note) {
//                     Navigator.of(context).pushNamed(
//                       createOrUpdateNoteRoute,
//                       arguments: note,
//                     );
//                   },
//                 );
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             default:
//               return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }