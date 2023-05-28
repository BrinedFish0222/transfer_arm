import 'package:flutter/material.dart';


class AppDropdownBtn<T> extends StatefulWidget {
  const AppDropdownBtn({Key? key, this.value, required this.onChanged, required this.items, this.alignment, this.icon}) : super(key: key);

  final T? value;
  final ValueChanged<T?> onChanged;
  final List<DropdownMenuItem<T>> items;
  final AlignmentGeometry? alignment;
  final Widget? icon;


  @override
  State<AppDropdownBtn<T>> createState() => _AppDropdownBtnState<T>();
}

class _AppDropdownBtnState<T> extends State<AppDropdownBtn<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      // 从枚举中取出当前状态，如果新建没有原状态，则取枚举第一个。
      value: widget.value,
      icon: widget.icon ?? const Icon(Icons.keyboard_arrow_right),
      underline: Container(),
      // style: ,
      isExpanded: true,
      onChanged: widget.onChanged,
      alignment: widget.alignment ?? AlignmentDirectional.centerStart,
      items: widget.items,
    );
  }
}

