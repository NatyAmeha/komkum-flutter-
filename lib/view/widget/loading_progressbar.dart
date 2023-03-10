import 'package:flutter/material.dart';

class LoadingProgressbar extends StatelessWidget {
  bool loadingState;

  LoadingProgressbar({this.loadingState = false});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loadingState,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
