import 'package:common_library/utils/database_helper.dart';

abstract class CommonMapper {
  List<T> listAll<T>() {
    return DatabaseHelper.instance.listAll<T>();
  }

  T? selectById<T>(int id) {
    return DatabaseHelper.instance.selectById<T>(id: id);
  }

  bool deleteById<T>(int id) {
    return DatabaseHelper.instance.deleteById<T>(id: id);
  }
}
