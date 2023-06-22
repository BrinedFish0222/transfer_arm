import 'package:common_library/utils/database_helper.dart';

abstract class CommonMapper {
  Future<List<T>> listAll<T>() async {
    return DatabaseHelper.instance.listAll<T>();
  }

  Future<T?> selectById<T>(int id) async {
    return DatabaseHelper.instance.selectById<T>(id: id);
  }

  Future<bool> deleteById<T>(int id) async {
    return DatabaseHelper.instance.deleteById<T>(id: id);
  }
}
