import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
      required this.title,
      this.autofocus = false,
      this.initialValue,
      this.onChanged,
      this.hintText,
      this.hintStyle,
      this.titleFlex,
      this.interval,
      this.keyboardType,
      this.inputFormatters,
      this.validator,
      this.maxLength,
      this.counterText})
      : super(key: key);

  final Widget title;
  final int? titleFlex;
  final double? interval;
  final int? maxLength;

  final String? initialValue;
  final String? hintText;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool autofocus;

  /// maxLength 的长度提示语
  final String? counterText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: titleFlex ?? 3, child: title),
        if (interval != null)
          SizedBox(
            width: interval,
          ),
        Expanded(
            flex: 7,
            child: TextFormField(
              autofocus: autofocus,
              initialValue: initialValue,
              // textAlign: textAlign ?? TextAlign.start,
              maxLength: maxLength,
              keyboardType: keyboardType,
              validator: validator,
              // maxLines: maxLines,
              textCapitalization: TextCapitalization.none,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,
                border: InputBorder.none,
                counterText: counterText,
              ),
              onChanged: onChanged,
            )),
      ],
    );
  }
}
