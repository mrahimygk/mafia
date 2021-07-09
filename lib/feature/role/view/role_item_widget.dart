import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:mafia/domain/model/role/role.dart';

class RoleItemWidget extends StatefulWidget {
  final Role item;

  const RoleItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoleItemWidgetState();
}

class _RoleItemWidgetState extends State<RoleItemWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (d) {
        setState(() {
          widget.item.isSelected = !widget.item.isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.item.group.id == 1
                ? widget.item.isSelected
                    ? Colors.red
                    : Colors.red.shade100
                : widget.item.group.id == 2
                    ? widget.item.isSelected
                        ? Colors.green
                        : Colors.green.shade100
                    : widget.item.isSelected
                        ? Colors.yellow
                        : Colors.yellow.shade100,
            border: Border(),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          padding: EdgeInsets.all(12.0),
          child: Text(
            "${widget.item.name.tr()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}