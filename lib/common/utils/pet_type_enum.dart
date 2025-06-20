enum PetType {
  DOG(1),
  CAT(2),
  BIRD(3),
  OTHER(4);

  final int value;
  const PetType(this.value);

  static PetType fromValue(int value) {
    return PetType.values.firstWhere((e) => e.value == value, orElse: () => PetType.OTHER);
  }

  static String toValueLabel(int value) {
    switch (value) {
      case 1:
        return 'Perros';
      case 2:
        return 'Gatos';
      case 3:
        return 'Pájaros';
      case 4:
        return 'Otros';
      default:
        return 'Otros';

    }
  }
}