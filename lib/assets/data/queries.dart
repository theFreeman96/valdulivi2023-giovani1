import 'database_helper.dart';
import 'models.dart';

class QueryCtr {
  DatabaseHelper con = DatabaseHelper.privateConstructor();

  Future<List<Songs>?> getAllSongs() async {
    final dbClient = await con.db;
    final res = await dbClient!.query('Songs', orderBy: 'id', groupBy: 'id');

    List<Songs>? list =
        res.isNotEmpty ? res.map((c) => Songs.fromMap(c)).toList() : null;

    return list;
  }

  Future<List<Songs>?> searchSong(String keyword) async {
    final dbClient = await con.db;
    final res = await dbClient!.query('Songs',
        where: 'id LIKE ? OR title LIKE ? OR text LIKE ?',
        whereArgs: ['%$keyword%', '%$keyword%', '%$keyword%'],
        groupBy: 'id',
        orderBy: 'id');

    List<Songs>? list =
        res.isNotEmpty ? res.map((c) => Songs.fromMap(c)).toList() : null;

    return list;
  }
}
