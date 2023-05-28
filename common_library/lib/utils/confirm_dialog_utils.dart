import 'package:flutter/material.dart';

class ConfirmDialogUtils {

  static Future<bool> isDeleteDialog(context) async {
    return await isConfirmDialog(context);
  }

  static Future<bool> isSaveDialog(context) async {
    return await isConfirmDialog(context, content: '是否保存', confirmBtnText: '保存', cancelBtnText: '不保存');
  }


  static Future<bool> isConfirmDialog(context, {String? content, String? title, String? confirmBtnText, String? cancelBtnText}) async {
    bool? flag = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? "提示"),
          content: Text(content ?? "确定删除吗？"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(cancelBtnText ?? "取消"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(confirmBtnText ?? "确定")),
          ],
        );
      },
    );

    return flag ?? false;
  }

}
