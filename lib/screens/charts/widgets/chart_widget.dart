import 'dart:math' as math;

import 'package:apartments/model/apartment_group.dart';
import 'package:apartments/model/group_item.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:stats/stats.dart';

class ChartWidget extends StatelessWidget {
  final GroupItem item;

  ChartWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(item.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: item.apartmentGroups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return stats(item.apartmentGroups[index]);
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width > 800
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width - 400,
                child: AspectRatio(
                  aspectRatio: 1.7,
                  child: charts.BarChart([
                    charts.Series<ApartmentGroup, String>(
                      displayName:
                          'Коэффициенты зависимости стоимости 1 кв.м. жилья на вторичном рынке от ${item.name.replaceAll('По ', '').toLowerCase()}',
                      id: item.name,
                      domainFn: (ApartmentGroup model, _) => model.name,
                      measureFn: (ApartmentGroup model, _) =>
                          _calculateValue(model),
                      data: item.apartmentGroups,
                      colorFn: (ApartmentGroup model, _) =>
                          charts.Color(a: 255, b: 200, r: 0, g: 100),
                      // Set a label accessor to control the text of the arc label.
                      labelAccessorFn: (ApartmentGroup row, _) => row.name,
                    ),
                  ]),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  stats(ApartmentGroup group) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 300,
              child: Text(group.name,
                  style: TextStyle(fontWeight: FontWeight.bold), maxLines: 3)),
          Container(
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Мин: ${group.minPrice.round()}'),
                    Text('Макс: ${group.maxPrice.round()}'),
                    Text('Среднее: ${group.averagePrice.round()}'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Сред. взвеш.: ${group.weightedAverage.round()}'),
                    Text('Медиана: ${group.median.round()}'),
                    Text('СКО: ${group.sko.round()}'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Кол-во: ${group.apartments.length.round()}'),
                    Text(
                        'Ниж. граница: ${(group.weightedAverage - (1.96 * group.sko / math.sqrt(group.apartments.length))).round()}'),
                    Text(
                        'Верх. граница: ${(group.weightedAverage + (1.96 * group.sko / math.sqrt(group.apartments.length))).round()}'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateValue(ApartmentGroup model) {
    return model.averagePrice /
        Stats.fromData(item.apartmentGroups
                .map((ApartmentGroup group) => group.averagePrice)
                .toList())
            .max;
  }
}
