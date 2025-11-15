enum City {
  brampton,
}

extension CityExtension on City {
  String toDisplayName() {
    switch (this) {
      case City.brampton:
        return 'Brampton';
    }
  }

  String toName() {
    switch (this) {
      case City.brampton:
        return 'brampton';
    }
  }
}

extension CityNameExtension on String {
  City toEnum() {
    switch (toLowerCase()) {
      case 'brampton':
        return City.brampton;
      default:
        throw ArgumentError('Invalid City name: $this');
    }
  }
}
