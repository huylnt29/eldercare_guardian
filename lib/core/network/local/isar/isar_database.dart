import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

mixin IsarDatabase {
  static late final Isar? isar;
  Isar? get isarInstance => isar;
  static Future<void> init() async {
    try {
      if (Isar.instanceNames.isNotEmpty) return;
      isar = await openIsar();
    } catch (error) {
      rethrow;
    }
  }

  static Future<Isar> openIsar() async {
    final appDir = await getApplicationDocumentsDirectory();
    final isarDir = Directory('${appDir.path}/isar');
    await isarDir.create(recursive: true);

    final isar = await Isar.open([
      // AccountSchema,
      // CustomerSchema,
    ], directory: isarDir.path, inspector: true);

    return isar;
  }

  static Future clearDatabase() async {
    // await isar?.writeTxn<void>(
    //   () async => await isar?.accounts.where().deleteAll(),
    // );
    // await isar?.writeTxn<void>(
    //   () async => await isar?.customers.where().deleteAll(),
    // );
  }

  static Future<bool?> dispose() async => isar?.close();
}

abstract class BaseLocalDatabase<T> {
  Stream<List<T>> listenDb() {
    throw UnimplementedError('listenDb $T');
  }

  Future<List<T>> getAll() {
    throw UnimplementedError('getAll $T');
  }

  Future<List<T>> gets({required int limit, required int offset}) {
    throw UnimplementedError('gets $T');
  }

  Future<T?> get(String id) {
    throw UnimplementedError('get $T');
  }

  Future<T?> getByKey(Id id) {
    throw UnimplementedError('getByKey $T');
  }

  Future<List<T>> filter() {
    throw UnimplementedError('filter $T');
  }

  Future<Id> insert(T model) {
    throw UnimplementedError('insert $T');
  }

  Future<bool> insertAll(List<T> models) {
    throw UnimplementedError('insert $T');
  }

  Future<Id> update(T model) {
    throw UnimplementedError('update $T');
  }

  Future<bool> delete(int id) {
    throw UnimplementedError('delete $T');
  }
}
