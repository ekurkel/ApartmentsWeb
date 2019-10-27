class Apartment {
  final String date;
  final int roomCount;
  final String county;
  final String street;
  final int floor;
  final int floorTotal;
  final String buildingType;
  final double livingSpace;
  final double totalSpace;
  final double kitchenSpace;
  final String condition;
  final double price;
  final double pricePerMeter;
  final String article;
  final String source;

  Apartment(
      {this.date,
      this.roomCount,
      this.county,
      this.street,
      this.floor,
      this.floorTotal,
      this.buildingType,
      this.livingSpace,
      this.totalSpace,
      this.kitchenSpace,
      this.condition,
      this.price,
      this.pricePerMeter,
      this.article,
      this.source});

  Apartment copyWith({
    String date,
    int roomCount,
    String county,
    String street,
    int floor,
    String floorTotal,
    String buildingType,
    double livingSpace,
    double totalSpace,
    double kitchenSpace,
    String condition,
    double price,
    double pricePerMeter,
    String article,
    String source,
  }) {
    return Apartment(
      date: date ?? this.date,
      roomCount: roomCount ?? this.roomCount,
      county: county ?? this.county,
      street: street ?? this.street,
      floor: floor ?? this.floor,
      floorTotal: floorTotal ?? this.floorTotal,
      buildingType: buildingType ?? this.buildingType,
      livingSpace: livingSpace ?? this.livingSpace,
      totalSpace: totalSpace ?? this.totalSpace,
      kitchenSpace: kitchenSpace ?? this.kitchenSpace,
      condition: condition ?? this.condition,
      price: price ?? this.price,
      pricePerMeter: pricePerMeter ?? this.pricePerMeter,
      article: article ?? this.article,
      source: source ?? this.source,
    );
  }

  List<dynamic> toTableRow() {
    return [
      this.date,
      this.roomCount,
      this.county,
      this.street,
      this.floor,
      this.floorTotal,
      this.buildingType,
      this.livingSpace,
      this.totalSpace,
      this.kitchenSpace,
      this.condition,
      this.price,
      this.pricePerMeter,
      this.article,
      this.source
    ];
  }

  factory Apartment.fromTableRow(List<dynamic> data) {
    try {
      return Apartment(
        date: (data[0] != null && data[0].length > 10)
            ? data[0].toString().substring(0, 10)
            : data[0] as String,
        roomCount: int.tryParse(data[1].toString()),
        county: data[2] as String,
        street: data[3] as String,
        floor: int.tryParse(data[4].toString()),
        floorTotal: int.tryParse(data[5].toString()),
        buildingType: data[6] as String,
        totalSpace: double.tryParse(data[7].toString()),
        livingSpace: double.tryParse(data[8].toString()),
        kitchenSpace: double.tryParse(data[9].toString()),
        condition: data[10] as String,
        price: double.tryParse(data[11].toString().replaceAll(',', '')),
        pricePerMeter: double.tryParse(data[12].toString()),
        article: data[13] as String,
        source: data[14] as String,
      );
    } catch (e, s) {
      print('$e, $s');
      return null;
    }
  }

  static bool isApartment(List<dynamic> data) {
    if ((data[0] == null) && (data[1] == null) && (data[2] == null)) {
      return false;
    } else {
      return true;
    }
  }
}
