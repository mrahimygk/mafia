import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String listSubject;
  final VoidCallback onAddClick;

  EmptyListWidget(this.listSubject, this.onAddClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("${"noData".tr()}, ${listSubject.tr()}"),
        IconButton(icon: Icon(Icons.add_circle_rounded), onPressed: onAddClick)
      ],
    );
  }
}
