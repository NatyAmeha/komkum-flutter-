import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';

class KeyPointWidget extends StatelessWidget {
  String text;
  KeyPointWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomContainer(
          height: 10,
          width: 10,
          color: Colors.grey,
          borderRadius: 5,
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: CustomText(
            text,
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
