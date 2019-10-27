import 'package:apartments/model/apartment_group.dart';
import 'package:apartments/model/group_item.dart';
import 'package:csv/csv.dart';
import 'package:stats/stats.dart';

class ApartmentTable {
  final List<GroupItem> items;
  static const List<dynamic> titlesList = [
    'дата',
    'кол-во комнат',
    'быт.район',
    'улица',
    'этаж',
    'этажность',
    'хар-ка здания',
    'S общ',
    'S жилая',
    'S кухни',
    'состояние',
    'цена общая',
    '1 М'
  ];

  ApartmentTable({this.items});

  factory ApartmentTable.fromTable(List<List<dynamic>> data) {
    List<GroupItem> listGroupItems = [];
    try {
      for (int i = 0; i < data.length; i++) {
        if (_isTitle(i, data)) {
          GroupItem item = GroupItem.fromTable(i, data);
          listGroupItems.add(item);
          item.apartmentGroups.forEach((ApartmentGroup group) {
            i += group.apartments.length;
          });
        }
      }
    } catch (e, s) {
      print('$e, $s');
    }
    return ApartmentTable(items: listGroupItems);
  }

  String toString() {
    List<List<dynamic>> spreadsheet = [];
    this.items.forEach((GroupItem group) {
      spreadsheet.add([group.name]);
      group.apartmentGroups.forEach((ApartmentGroup apTable) {
        spreadsheet.add([apTable.name]);
        //       spreadsheet.add(titlesList);
//        apTable.apartments.forEach((Apartment apartment) {
//          spreadsheet.add(apartment.toTableRow());
//        });
        spreadsheet.add([]);
        spreadsheet.add([
          'мин',
          'макс',
          'среднее',
          'срвзвеш.',
          'медиана',
          'СКО',
          'кол-во',
          'нижн.гран.',
          'верхн.гран.',
        ]);
        spreadsheet.add(apTable.listStats());
        spreadsheet.add([
          'Коэффициенты:',
          apTable.bottomLine /
              Stats.fromData(group.apartmentGroups
                      .map((ApartmentGroup group) => group.averagePrice)
                      .toList())
                  .max,
          apTable.topLine /
              Stats.fromData(group.apartmentGroups
                      .map((ApartmentGroup group) => group.averagePrice)
                      .toList())
                  .max,
          apTable.averagePrice /
              Stats.fromData(group.apartmentGroups
                      .map((ApartmentGroup group) => group.averagePrice)
                      .toList())
                  .max,
        ]);
        spreadsheet.add([]);
        spreadsheet.add([]);
      });
      spreadsheet.add([]);
    });

    String csv = const ListToCsvConverter().convert(spreadsheet);
    return csv;
  }

  static bool _isTitle(int i, List<List<dynamic>> data) {
    try {
      if (i < data.length - 1) {
        if (data[i][0] != null) {
          if (data[i][0] is String) {
            if (data[i][0].isNotEmpty) {
              if (data[i + 2][0] is String) {
                if (data[i + 2][0] == 'дата') {
                  return true;
                }
              }
            }
          }
        }
      }
    } catch (e) {}
    return false;
  }
}
