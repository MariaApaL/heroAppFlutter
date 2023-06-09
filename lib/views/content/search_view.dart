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
          _superheroes = superheroData.superheroes ??
              []; // Actualiza la lista de superhéroes encontrados
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
        _superheroes =
            []; // Vacía la lista de superhéroes si la consulta está vacía
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchSuperheroes(
        "a"); // Realiza una búsqueda inicial con una consulta predeterminada
  }

  @override
  Widget build(BuildContext context) {
    SuperheroResponse? superhero =
        _superheroes.isNotEmpty ? _superheroes[_current] : null;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.095,
              left: 0,
              right: 0,
              bottom: 20,
              child: superhero != null
                  ? Image.network(superhero.superheroImage.url,
                      fit: BoxFit.cover)
                  : Container(),
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: -100,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(255, 223, 80, 80).withOpacity(1),
                      Color.fromARGB(255, 161, 24, 24).withOpacity(1),
                      Color.fromARGB(255, 243, 112, 112).withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
 Positioned(
  top: 30,
  left: 0,
  right: 0,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: TextField(
      controller: _searchController,
      onChanged: (query) {
        _searchSuperheroes(query);
      },
      decoration: const InputDecoration(
        hintText: 'Search Superheroes',
        prefixIcon:  Icon(
          Icons.search,
          color: Color.fromARGB(255, 130, 26, 18),
        ),
      
      ),
    ),
  ),
),
            Positioned(
              bottom: -70,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Visibility(
                visible: !_isLoading,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: _superheroes.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          height: 410.0,
                          aspectRatio: 10 / 9,
                          viewportFraction: 0.70,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        carouselController: _carouselController,
                        items: _superheroes.map((superhero) {
                          return SuperheroCard(
                            superhero: superhero,
                            onFavoriteRemoved: () {},
                          );
                        }).toList(),
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
