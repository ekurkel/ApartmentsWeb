import 'dart:html' as html;
import 'dart:math' as math;

import 'package:apartments/model/apartment.dart';
import 'package:apartments/model/apartment_group.dart';
import 'package:flutter/material.dart';

class ApartmentsListScreen extends StatefulWidget {
  final ApartmentGroup group;

  const ApartmentsListScreen({Key key, this.group}) : super(key: key);

  @override
  _ApartmentsListScreenState createState() => _ApartmentsListScreenState();
}

class _ApartmentsListScreenState extends State<ApartmentsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.group.name)),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return Column(
      children: <Widget>[
        stats(widget.group),
        Divider(height: 0),
        title(),
        Expanded(
          child: ListView.builder(
            itemCount: widget.group.apartments.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: InkWell(
                      onTap: () async {
                        try {
                          html.window.open(
                              widget.group.apartments[index].source, 'source');
                        } catch (e) {}
                      },
                      child: apartment(
                          apartment: widget.group.apartments[index])));
            },
          ),
        ),
      ],
    );
  }

  Widget apartment({Apartment apartment}) {
    return Row(
      children: <Widget>[
        _textField(
            title: 'Дата', value: apartment.date, keyboard: TextInputType.text),
        _textField(
            title: 'Кол-во комтнат',
            value: apartment.roomCount,
            keyboard: TextInputType.number),
        _textField(
            title: 'Быт.район',
            value: apartment.county,
            keyboard: TextInputType.text),
        _textField(
            title: 'Улица',
            value: apartment.street,
            keyboard: TextInputType.text),
        _textField(
            title: 'Этаж',
            value: apartment.floor,
            keyboard: TextInputType.number),
        _textField(
            title: 'Этажность',
            value: apartment.floorTotal,
            keyboard: TextInputType.number),
        _textField(
            title: 'Хар-ка здания',
            value: apartment.buildingType,
            keyboard: TextInputType.text),
        _textField(
            title: 'S общ',
            value: apartment.totalSpace,
            keyboard: TextInputType.number),
        _textField(
            title: 'S жилая',
            value: apartment.livingSpace,
            keyboard: TextInputType.number),
        _textField(
            title: 'S кухни',
            value: apartment.kitchenSpace,
            keyboard: TextInputType.number),
        _textField(
            title: 'Состояние',
            value: apartment.condition,
            keyboard: TextInputType.text),
        _textField(
            title: 'Цена',
            value: apartment.price,
            keyboard: TextInputType.number),
      ],
    );
  }

  Widget _textField({String title, dynamic value, TextInputType keyboard}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(value != null ? value.toString() : '', maxLines: 3)
          ],
        ),
      ),
    );
  }

  title() {
    return Row(children: <Widget>[
      Expanded(child: Center(child: Text('Дата'))),
      Expanded(child: Center(child: Text('Кол-во комтнат'))),
      Expanded(child: Center(child: Text('Быт.район'))),
      Expanded(child: Center(child: Text('Улица'))),
      Expanded(child: Center(child: Text('Этаж'))),
      Expanded(child: Center(child: Text('Этажность'))),
      Expanded(child: Center(child: Text('Хар-ка здания'))),
      Expanded(child: Center(child: Text('S общ'))),
      Expanded(child: Center(child: Text('S жилая'))),
      Expanded(child: Center(child: Text('S кухни'))),
      Expanded(child: Center(child: Text('Состояние'))),
      Expanded(child: Center(child: Text('Цена'))),
    ]);
  }

  stats(ApartmentGroup group) {
    return Container(
      color: Colors.indigo,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Center(
                    child: Text(
              'Мин: ${widget.group.minPrice.round()}',
              style: TextStyle(color: Colors.white),
            ))),
            Expanded(
                child: Center(
                    child: Text('Макс: ${widget.group.maxPrice.round()}',
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text('Среднее: ${widget.group.averagePrice.round()}',
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text(
                        'Сред. взвеш.: ${widget.group.weightedAverage.round()}',
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text('Медиана: ${widget.group.median.round()}',
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text('СКО: ${widget.group.sko.round()}',
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text(
                        'Кол-во: ${widget.group.apartments.length.round()}',
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text(
                        'Ниж. граница: ${(widget.group.weightedAverage - (1.96 * widget.group.sko / math.sqrt(widget.group.apartments.length))).round()}',
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text(
                        'Верх. граница: ${(widget.group.weightedAverage + (1.96 * widget.group.sko / math.sqrt(widget.group.apartments.length))).round()}',
                        style: TextStyle(color: Colors.white)))),
          ],
        ),
      ),
    );
  }
}
