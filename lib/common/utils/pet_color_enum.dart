enum PetColor {
  WHITE(1),
  BLACK(2),
  BROWN(3),
  GRAY(4),
  MIXED(5);

  final int value;
  const PetColor(this.value);

  static PetColor fromValue(int value) {
    return PetColor.values.firstWhere((e) => e.value == value, orElse: () => PetColor.MIXED);
  }

  static String toValueLabel(int value) {
    switch (value) {
      case 1:
        return 'Blanco';
      case 2:
        return 'Negro';
      case 3:
        return 'Marrón';
      case 4:
        return 'Gris';
      case 5:
        return 'Mixto';
      default:
        return 'Mixto';
    }
  }
}