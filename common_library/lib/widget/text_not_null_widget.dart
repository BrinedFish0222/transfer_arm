import 'package:common_library/widget/single_line_fitted_box.dart';
import 'package:flutter/material.dart';

class TextNotNullWidget extends StatelessWidget {
  const TextNotNullWidget(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleLineFittedBox(
      child: Row(
        children: [
          Text(text),
          const SizedBox(width: 5),
          const Text(
            "*",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
