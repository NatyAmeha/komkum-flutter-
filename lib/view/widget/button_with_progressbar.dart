import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/loading_progressbar.dart';

class ButtonWithProgressbar extends StatelessWidget {
  String text;
  bool isLoading;
  Function onClick;
  double fontSize;
  ButtonWithProgressbar({
    required this.text,
    required this.isLoading,
    required this.onClick,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !isLoading
          ? () {
              onClick();
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) const CircularProgressIndicator(),
            const SizedBox(width: 24),
            CustomText(
              text,
              textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}
