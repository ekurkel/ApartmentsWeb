import 'dart:math';

import 'package:apartments/model/apartment.dart';
import 'package:stats/stats.dart';

class ApartmentGroup {
  final String name;
  final List<Apartment> apartments;
  double minPrice;
  double maxPrice;
  double averagePrice;
  double weightedAverage;
  double median;
  double sko;
  double bottomLine;
  double topLine;

  ApartmentGroup({this.name, this.apartments}) {
    minPrice = getMinPrice(apartments);
    maxPrice = getMaxPrice(apartments);
    averagePrice = getAveragePrice(apartments);
    weightedAverage = getWeightedAverage(apartments);
    median = getMedian(apartments);
    sko = getSKO(apartments);
    bottomLine = weightedAverage - (1.96 * sko / sqrt(apartments.length));
    topLine = weightedAverage + (1.96 * sko / sqrt(apartments.length));
  }

  ApartmentGroup copyWith({
    String name,
    String description,
    List<Apartment> apartments,
  }) {
    return ApartmentGroup(
      name: name ?? this.name,
      apartments: apartments ?? this.apartments,
    );
  }

  factory ApartmentGroup.fromTable(int startIndex, List<List<dynamic>> data) {
    List<Apartment> apartments = [];
    for (int i = startIndex + 2; i < data.length; i++) {
      if (Apartment.isApartment(data[i])) {
        apartments.add(Apartment.fromTableRow(data[i]));
      } else {
        try {
          return ApartmentGroup(
              name: data[startIndex][0], apartments: apartments);
        } catch (e, s) {
          print('$e, $s');
        }
      }
    }
    return ApartmentGroup(name: data[startIndex][0], apartments: apartments);
  }

  double getMinPrice(List<Apartment> apartments) {
    return Stats.fromData(apartments
            .map((Apartment a) => a.pricePerMeter ?? double.infinity)
            .toList())
        .min;
  }

  double getMaxPrice(List<Apartment> apartments) {
    return Stats.fromData(
            apartments.map((Apartment a) => a.pricePerMeter ?? 0).toList())
        .max;
  }

  double getAveragePrice(List<Apartment> apartments) {
    return Stats.fromData(
            apartments.map((Apartment a) => a.pricePerMeter ?? 0).toList())
        .mean;
  }

  double getWeightedAverage(List<Apartment> apartments) {
    double allPrices = 0;
    double allAreas = 0;
    apartments.forEach((Apartment a) {
      if (a.price != null && a.totalSpace != null) {
        allPrices += a.price;
        allAreas += a.totalSpace;
      }
    });
    return allPrices / allAreas;
  }

  double getMedian(List<Apartment> apartments) {
    return Stats.fromData(
            apartments.map((Apartment a) => a.pricePerMeter ?? 0).toList())
        .median;
  }

  double getSKO(List<Apartment> apartments) {
    return Stats.fromData(
            apartments.map((Apartment a) => a.pricePerMeter ?? 0).toList())
        .standardDeviation;
  }

  List<dynamic> listStats() {
    return [
      minPrice.round(),
      maxPrice.round(),
      averagePrice.round(),
      weightedAverage.round(),
      median.round(),
      sko.round(),
      apartments.length.round(),
      bottomLine.round(),
      topLine.round(),
    ];
  }
}
