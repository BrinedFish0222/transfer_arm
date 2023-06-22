import 'package:path_provider/path_provider.dart';
import 'package:transfer_arm/objectbox.g.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static late DatabaseHelper _databaseHelper;

  late final Store store;

  DatabaseHelper._create(this.store);

  static DatabaseHelper get instance => _databaseHelper;

  static Future<DatabaseHelper> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    Store store = await openStore(directory: join(docsDir.path, "obx-example"));
    _databaseHelper = DatabaseHelper._create(store);
    return _databaseHelper;
  }

  Box<T> getBox<T>() {
    return store.box<T>();
  }

  /// 开启事务
  T transaction<T>(T Function() function, {TxMode txMode = TxMode.write}) {
    return store.runInTransaction(txMode, function);
  }

  List<T> select<T>([Condition<T>? qc]) {
    final box = store.box<T>();
    final query = box.query(qc).build();
    List<T> result = query.find();
    query.close();
    return result;
  }

  List<int> saveBatch<T>({required List<T>? dataList}) {
    final box = store.box<T>();
    return box.putMany(dataList!);
  }

  int save<T>({required T data}) {
    final box = store.box<T>();
    return box.put(data);
  }

  List<T> listAll<T>() {
    final box = store.box<T>();
    return box.getAll();
  }

  /// 根据id查询数据
  T? selectById<T>({
    required int id,
  }) {
    final box = store.box<T>();
    return box.get(id);
  }

  /// 根据id查询数据
  List<T?> selectByIds<T>({
    required List<int> ids,
  }) {
    final box = store.box<T>();
    return box.getMany(ids);
  }

  // 示例：删除数据
  bool deleteById<T>({required int id}) {
    final box = store.box<T>();
    return box.remove(id);
  }

  void deleteByIds<T>({required List<int> ids}) {
    final box = store.box<T>();
    box.removeMany(ids);
  }

  void deleteAll<T>() {
    final box = store.box<T>();
    box.removeAll();
  }

  int count<T>() {
    final box = store.box<T>();
    return box.count();
  }
}
