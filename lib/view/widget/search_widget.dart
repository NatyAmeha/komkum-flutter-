import 'package:flutter/material.dart';
import 'package:komkum/view/widget/custom_container.dart';

class SearchBar extends StatelessWidget {
  String hintText;
  bool isActive;
  double borderRadius;
  IconData? prefixIcon;
  Function? prefixIconAction;

  SearchBar({
    this.hintText = "Search songs, albums and playlists",
    this.prefixIcon,
    this.prefixIconAction,
    this.borderRadius = 32,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Theme.of(context).backgroundColor,
      padding: 16,
      borderRadius: borderRadius,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (prefixIcon != null)
            InkWell(
                onTap: prefixIconAction?.call(),
                child: Icon(prefixIcon, size: 20)),
          Text(hintText, style: Theme.of(context).textTheme.bodyLarge),
          const Icon(Icons.search)
        ],
      ),
    );
  }
}
