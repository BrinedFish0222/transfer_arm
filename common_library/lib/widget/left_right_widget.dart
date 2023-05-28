import 'package:flutter/material.dart';

class LeftRightWidget extends StatelessWidget {
  const LeftRightWidget({Key? key, required this.leftChild, required this.rightChild}) : super(key: key);

  final Widget leftChild;
  final Widget rightChild;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
            flex: 3,
            child: leftChild),
        Expanded(
          flex: 7,
          child: rightChild,
        ),
      ],
    );
  }
}
