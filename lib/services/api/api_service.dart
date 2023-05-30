import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/superhero_api_model.dart';
import 'models/superhero_details_api_model.dart';

class SuperheroApiService {
  final String baseUrl = 'https://superheroapi.com/api/10231204575760255';


  Future<SuperheroApiModel> getSuperhero(String superheroName) async {
    final response = await http.get(Uri.parse('$baseUrl/search/$superheroName'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuperheroApiModel.fromJson(json);
    } else {
      throw Exception('Failed to fetch superhero');
    }
  }
  

  Future<SuperheroDetailsApiModel> getSuperheroDetails(String superheroId) async {
    final response = await http.get(Uri.parse('$baseUrl/$superheroId'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuperheroDetailsApiModel.fromJson(json);
    } else {
      throw Exception('Failed to fetch superhero details');
    }
  }
}