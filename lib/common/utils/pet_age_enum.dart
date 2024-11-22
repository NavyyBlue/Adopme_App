enum PetAge {
  PUPPY(1),
  ADULT(2),
  SENIOR(3);

  final int value;
  const PetAge(this.value);

  static PetAge fromValue(int value) {
    return PetAge.values.firstWhere((e) => e.value == value, orElse: () => PetAge.ADULT);
  }

  static String toValueLabel(int value) {
    switch (value) {
      case 1:
        return 'Cachorro';
      case 2:
        return 'Adulto';
      case 3:
        return 'Anciano';
      default:
        return 'Cachorro';
    }
  }
}