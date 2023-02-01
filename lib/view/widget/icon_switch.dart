import 'package:flutter/material.dart';

class IconSwitch extends StatelessWidget {
  Map<IconData, Function> icons;
  IconData selectedIcon;
  IconSwitch({
    required this.icons,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    var selected =
        icons.entries.where((element) => element.key == selectedIcon).first;
    return InkWell(
      onTap: () {
        selected.value();
      },
      child: Icon(selected.key),
    );
  }
}
