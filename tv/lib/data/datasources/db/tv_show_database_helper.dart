import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tv/data/models/tv_show_table.dart';

class TvShowDatabaseHelper {
  static TvShowDatabaseHelper? _databaseHelper;

  TvShowDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TvShowDatabaseHelper() =>
      _databaseHelper ?? TvShowDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblWatchlistTvShow = 'watchlistTvShow';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_tv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblWatchlistTvShow (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchListTvShow(TvShowTable tvShowTable) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvShow, tvShowTable.toJson());
  }

  Future<int> removeWatchlistTvShow(TvShowTable tvShow) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvShow,
      where: 'id = ?',
      whereArgs: [tvShow.id],
    );
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShow() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistTvShow);

    return results;
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvShow,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
