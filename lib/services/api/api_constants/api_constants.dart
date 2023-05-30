class ApiConstants {
  static String baseUrl = 'https://superheroapi.com/api/10231204575760255';


  static String getSuperheroNameEndpoint(String name) {
    return '/search/$name';
  }
  
  static String getSuperheroIdEndpoint(String id) {
    return '/$id';
  }
}