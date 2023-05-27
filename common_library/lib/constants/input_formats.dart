import 'package:flutter/services.dart';
import '../utils/string_util.dart';

class InputFormats {
  /// 数值输入
  static TextInputFormatter numInputFormat =
      FilteringTextInputFormatter.allow(RegExp(r'[-\d.]?'));
}

class InputValidator {
  static get numValidator => (val) {
        try {
          if (val == null || val == '') {
            return null;
          }
          num.parse(val);
          return null;
        } catch (e) {
          return '请输入正确格式';
        }
      };

  static get numValidatorNotNull => (val) {
        try {
          if (val == null || val == '') {
            return '不能为空';
          }
          num.parse(val);
          return null;
        } catch (e) {
          return '请输入正确格式';
        }
      };

  static get notNull => (val) {
        if (StringUtil.isBlank(val)) {
          return '不能为空';
        }

        return null;
      };
}
