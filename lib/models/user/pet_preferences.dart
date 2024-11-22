class PetPreferences {
  int? petType;
  Size? size;
  int? age;
  int? color;

  PetPreferences({this.petType, this.size, this.age, this.color});

  PetPreferences.fromJson(Map<String, dynamic> json) {
    petType = json['petType'];
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
    age = json['age'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['petType'] = petType;
    if (size != null) {
      data['size'] = size!.toJson();
    }
    data['age'] = age;
    data['color'] = color;
    return data;
  }

  bool isEmpty() {
    return petType == null && size == null && age == null && color == null;
  }
}

class Size {
  int? min;
  int? max;

  Size({this.min, this.max});

  Size.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    return data;
  }

  bool isEmpty() {
    return min == null && max == null;
  }
}