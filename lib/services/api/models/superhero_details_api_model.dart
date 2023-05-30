class SuperheroDetailsApiModel {
  final String name;
  final PowerStatsResponse powerstats;
  final SuperheroImageDetailResponse image;
  final Biography biography;
  final Appearance appearance;
  final Work work;

  SuperheroDetailsApiModel({
    required this.name,
    required this.powerstats,
    required this.image,
    required this.biography,
    required this.appearance,
    required this.work,
  });

  factory SuperheroDetailsApiModel.fromJson(Map<String, dynamic> json) {
    return SuperheroDetailsApiModel(
      name: json['name'],
      powerstats: PowerStatsResponse.fromJson(json['powerstats']),
      image: SuperheroImageDetailResponse.fromJson(json['image']),
      biography: Biography.fromJson(json['biography']),
      appearance: Appearance.fromJson(json['appearance']),
      work: Work.fromJson(json['work']),
    );
  }
}

class PowerStatsResponse {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;

  PowerStatsResponse({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
  });

  factory PowerStatsResponse.fromJson(Map<String, dynamic> json) {
    return PowerStatsResponse(
      intelligence: json['intelligence'],
      strength: json['strength'],
      speed: json['speed'],
      durability: json['durability'],
      power: json['power'],
    );
  }
}

class SuperheroImageDetailResponse {
  final String url;

  SuperheroImageDetailResponse({
    required this.url,
  });

  factory SuperheroImageDetailResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroImageDetailResponse(
      url: json['url'],
    );
  }
}

class Biography {
  final String fullName;
  final String publisher;
  final String firstAppearance;

  Biography({
    required this.fullName,
    required this.publisher,
    required this.firstAppearance,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['full-name'],
      publisher: json['publisher'],
      firstAppearance: json['first-appearance'],
    );
  }
}

class Appearance {
  final String gender;
  final String race;

  Appearance({
    required this.gender,
    required this.race,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      gender: json['gender'],
      race: json['race'],
    );
  }
}

class Work {
  final String occupation;

  Work({
    required this.occupation,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      occupation: json['occupation'],
    );
  }
}