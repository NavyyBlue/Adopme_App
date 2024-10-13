class Vet {
  String? address;
  String? link;
  String? mainCategory;
  String? name;
  String? placeId;
  double? rating;
  int? reviews;
  double? latitude;
  double? longitude;

  Vet(
      {this.address,
        this.link,
        this.mainCategory,
        this.name,
        this.placeId,
        this.rating,
        this.reviews,
        this.latitude,
        this.longitude});

  Vet.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    link = json['link'];
    mainCategory = json['main_category'];
    name = json['name'];
    placeId = json['place_id'];
    rating = (json['rating'] as num?)?.toDouble();
    reviews = json['reviews'];

    // Extraer latitud y longitud de la URL
    if (link != null) {
      final regex = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)');
      final match = regex.firstMatch(link!);
      if (match != null) {
        latitude = double.tryParse(match.group(1)!);
        longitude = double.tryParse(match.group(2)!);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['link'] = link;
    data['main_category'] = mainCategory;
    data['name'] = name;
    data['place_id'] = placeId;
    data['rating'] = rating;
    data['reviews'] = reviews;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}