class SuperheroApiModel {
  List<SuperheroResponse>? superheroes;

  SuperheroApiModel({
    this.superheroes,
  });

//Array de superheroes
   factory SuperheroApiModel.fromJson(Map<String, dynamic> json) {
    return SuperheroApiModel(
      superheroes: json['results'] != null ? List<SuperheroResponse>.from(json['results'].map((x) => SuperheroResponse.fromJson(x))) : null,
    );
  }

}

class SuperheroResponse {
  final String superheroId;
  final String name;
  final SuperheroImageResponse superheroImage;

  SuperheroResponse({
    required this.superheroId,
    required this.name,
    required this.superheroImage,
  });

  factory SuperheroResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroResponse(
      superheroId: json['id'],
      name: json['name'],
      superheroImage: SuperheroImageResponse.fromJson(json['image']),
    );
  }
}

class SuperheroImageResponse {
  final String url;

  SuperheroImageResponse({
    required this.url,
  });

  factory SuperheroImageResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroImageResponse(
      url: json['url'],
    );
  }
}
