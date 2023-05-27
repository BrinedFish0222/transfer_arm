import 'package:flutter/material.dart';

class TextNotNullWidget extends StatelessWidget {
  const TextNotNullWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(text),
      const SizedBox(width: 5),
      const Text("*", style: TextStyle(color: Colors.red),),
    ],);
  }
}
