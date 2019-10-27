import 'package:apartments/model/apartment_group.dart';
import 'package:apartments/model/group_item.dart';
import 'package:apartments/screens/apartments/apartments_list_screen.dart';
import 'package:apartments/utils/navigation.dart';
import 'package:flutter/material.dart';

class TableItemWidget extends StatefulWidget {
  final GroupItem content;

  const TableItemWidget({Key key, this.content}) : super(key: key);
  @override
  _TableItemWidgetState createState() => _TableItemWidgetState();
}

class _TableItemWidgetState extends State<TableItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: ExpansionTile(
          title: Text(widget.content.name),
          children: widget.content.apartmentGroups
              .map((ApartmentGroup group) => ApartmentGroupWidget(group: group))
              .toList(),
        ),
      ),
    );
  }
}

class ApartmentGroupWidget extends StatefulWidget {
  final ApartmentGroup group;

  const ApartmentGroupWidget({Key key, this.group}) : super(key: key);
  @override
  _ApartmentGroupWidgetState createState() => _ApartmentGroupWidgetState();
}

class _ApartmentGroupWidgetState extends State<ApartmentGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Card(
        child: ListTile(
          onTap: () async {
            await Navigation.toScreen(
                context: context,
                screen: ApartmentsListScreen(group: widget.group));
          },
          title: Text(widget.group.name),
          subtitle: Text('Объявлений: ${widget.group.apartments.length}'),
        ),
      ),
    );
  }
}
