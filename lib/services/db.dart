import 'dart:async';
import 'package:coins/models/model.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {

	static Database _db;

	static int get _version => 1;

	static Future<void> init() async {
      debugPrint('Init');

		if (_db != null) { 
      debugPrint('DB already exist');
      return; }

		try {
			String _path = await getDatabasesPath() + 'example';
      debugPrint(_path);
			_db = await openDatabase(_path, version: _version, onCreate: onCreate);
		}
		catch(ex) { 
      debugPrint('DB init Exception');
      debugPrint(ex);

		}
	}

	static void onCreate(Database db, int version) async =>
		await db.execute('CREATE TABLE expanse_items (id INTEGER PRIMARY KEY AUTOINCREMENT, amount REAL, causal TEXT, date TEXT)');

	static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

	static Future<int> insert(String table, Model model) async =>
		await _db.insert(table, model.toMap());
	
	static Future<int> update(String table, Model model) async =>
		await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

	static Future<int> delete(String table, Model model) async =>
		await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}