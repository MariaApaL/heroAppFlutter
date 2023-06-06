import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../services/api/api_service.dart';
import '../../services/api/models/superhero_api_model.dart';
import '../cards/superhero_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final SuperheroApiService _apiService = SuperheroApiService();
  bool _isLoading = false;
  List<SuperheroResponse> _superheroes = [];
  int _current = 0;
  CarouselController _carouselController = CarouselController();

  void _searchSuperheroes(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Llama a la API y obtiene la lista de superhéroes que coinciden con la consulta
        SuperheroApiModel superheroData = await _apiService.getSuperhero(query);
        setState(() {
          _superheroes = superheroData.superheroes ?? []; // Actualiza la lista de superhéroes encontrados
        });
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _superheroes = []; // Vacía la lista de superhéroes si la consulta está vacía
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchSuperheroes("a"); // Realiza una búsqueda inicial con una consulta predeterminada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchSuperheroes,
              decoration: const InputDecoration(
                labelText: 'Search by superhero name',
              ),
            ),
          ),
          Visibility(
            visible: !_isLoading, // Verifica si la búsqueda está en curso para mostrar u ocultar el CircularProgressIndicator
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Expanded(
              child: CarouselSlider.builder(
                itemCount: _superheroes.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  SuperheroResponse superhero = _superheroes[index];
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(superhero.superheroImage.url),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SuperheroCard(
                      superhero: superhero,
                      onFavoriteRemoved: () {},
                    ),
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.45,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class _SearchViewState extends State<SearchView> {
//   final TextEditingController _searchController = TextEditingController();
//   final SuperheroApiService _apiService = SuperheroApiService();
//   bool _isLoading = false;
//   List<SuperheroResponse> _superheroes = [];

//   void _searchSuperheroes(String query) async {
//     if (query.isNotEmpty) { 
//       setState(() {
//         _isLoading = true; 
//       });

//       try {
//         // Llama a la api y obtiene la lista de superhéroes que coinciden con la consulta
//         SuperheroApiModel superheroData = await _apiService.getSuperhero(query);
//         setState(() {
//           _superheroes = superheroData.superheroes ?? []; // Actualiza la lista de superhéroes encontrados
//         });
//       } catch (e) {
//         print(e);
//       } finally {
//         setState(() {
//           _isLoading = false; 
//         });
//       }
//     } else {
//       setState(() {
//         _superheroes = []; // Vacía la lista de superhéroes si la consulta está vacía
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _searchSuperheroes("a"); // Realiza una búsqueda inicial con una consulta predeterminada
//   }

//     @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Superhero Search'),
//       ),
//       body: Container(
//         child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: _searchSuperheroes,
//               decoration: const InputDecoration(
//                 labelText: 'Search by superhero name',
//               ),
//             ),
//           ),
//           Expanded(
//             child: Visibility(
//               visible: !_isLoading, // Verifica si la búsqueda está en curso para mostrar u ocultar el CircularProgressIndicator
//               replacement: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//               child: ListView.builder(
//                 itemCount: _superheroes.length, // Número de elementos en la lista de superhéroes
//                 itemBuilder: (context, index) {
//                   SuperheroResponse superhero = _superheroes[index]; // Obtiene el superhéroe correspondiente al índice actual
//                   return SuperheroCard(superhero: superhero,
//                   onFavoriteRemoved: () {},); // Crea un widget SuperheroCard para mostrar la información del superhéroe
//                 },
//               ),
//             ),
//           ),
      
//         ],
      
//       ),
//       ),
//     );
//   }
// }
