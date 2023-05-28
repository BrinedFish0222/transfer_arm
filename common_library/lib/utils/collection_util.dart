
/// 集合工具
class CollectionUtil {

  /// 是否为空
  static bool isEmpty(List? dataList) {
    return dataList == null || dataList.isEmpty;
  }

  /// 是否不为空
  static bool isNotEmpty(List? dataList) {
    return !isEmpty(dataList);
  }

}
