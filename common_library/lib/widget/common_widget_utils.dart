import 'package:flutter/material.dart';

/// 通用widget
class CommonWidgetUtils {
  static Future<String?> buildInputDialog(
      {required BuildContext context,
      required String title,
      String? initValue,
      int? maxLength,
      String? hintText,
      String? confirmBtnText,
      bool hasBackBtn = true}) async {

    String result = '';

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: TextField(
          keyboardType: TextInputType.text,
          maxLength: maxLength,
          decoration: InputDecoration(hintText: hintText ?? ''),
          autofocus: true,
          onChanged: (val) => result = val,
        ),
        actions: <Widget>[
          if (hasBackBtn)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context, result),
            child: Text(confirmBtnText ?? '确认'),
          ),
        ],
      ),
    );
  }

  /// showDialog
  static Future<bool> isDeleteDialog(context, {String? content}) async {
    bool? flag = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("提示"),
          content: Text(content ?? "确定删除吗？"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("取消"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("确定")),
          ],
        );
      },
    );

    return flag ?? false;
  }

  /// 分页插件：无数据显示
  static buildNoDataWidget({String? text}) {
    return Center(
      child: Text(text ?? '无数据', style: const TextStyle(color: Colors.grey)),
    );
  }

  /// 分页插件：无更多数据显示。
  static buildNoMoreDataWidget({Widget? widget}) {
    if (widget != null) {
      return widget;
    }
    return const Center(
      child: Text(
        '没有更多了',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  /// 分页插件：首次加载错误显示。
  static buildFirstPageErrorWidget({VoidCallback? onTryAgain}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            const Text(
              '服务器繁忙，请稍后...',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 48,
            ),
            if (onTryAgain != null)
              SizedBox(
                height: 30,
                width: 120,
                child: ElevatedButton.icon(
                  onPressed: onTryAgain,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  label: const Text(
                    '刷新',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
