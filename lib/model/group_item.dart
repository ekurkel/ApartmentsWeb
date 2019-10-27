import 'package:apartments/model/apartment_group.dart';

class GroupItem {
  final String name;
  final List<ApartmentGroup> apartmentGroups;

  GroupItem({this.name, this.apartmentGroups});

  GroupItem copyWith({
    String name,
    List<ApartmentGroup> apartmentGroups,
  }) {
    return GroupItem(
        name: name ?? this.name,
        apartmentGroups: apartmentGroups ?? this.apartmentGroups);
  }

  factory GroupItem.fromTable(int startIndex, List<List<dynamic>> data) {
    List<ApartmentGroup> apartmentGroups = [];
    for (int i = startIndex + 1; i < data.length; i++) {
      if (_isTitle(i, data)) {
        return GroupItem(
            name: data[startIndex][0], apartmentGroups: apartmentGroups);
      } else if (_isSubTitle(i, data)) {
        ApartmentGroup group = ApartmentGroup.fromTable(i, data);
        apartmentGroups.add(group);
        i += group.apartments.length;
      }
    }
    print(apartmentGroups.length);
    return GroupItem(
        name: data[startIndex][0], apartmentGroups: apartmentGroups);
  }

  static bool _isSubTitle(int i, List<List<dynamic>> data) {
    try {
      if (i < data.length - 1) {
        if (data[i][0] != null) {
          if (data[i][0] is String) {
            if (data[i][0].isNotEmpty) {
              if (data[i + 1][0] is String) {
                if (data[i + 1][0] == 'дата') {
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
