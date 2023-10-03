import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import 'contatto.dart';

//classe per creare tutti i metodi per salvare  e recuperare i dati
class DataBaseManager {
  static final DataBaseManager instance = DataBaseManager._();
  DataBaseManager._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'rubrica.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
 CREATE TABLE rubrica(
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 nome VARCHAR(20) NOT NULL,
 cognome VARCHAR(20)  NOT NULL,
 numero VARCHAR(10) NOT NULL,
 email TEXT,
 iniziale TEXT
 )
 ''');
  }

  //metodi

  //per ritornare la lista dei contatti
  Future<List<Contatto>> getContatto() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('rubrica', orderBy: 'nome ASC');
    return List.generate(maps.length, (i) {
      return Contatto.fromMap(maps[i]);
    });
  }

//inserire un contatto
  Future<int> insertConttato(Contatto contatto) async {
    final db = await database;
    return await db.insert('rubrica', contatto.toMap());
  }

  //eliminare un contatto
  Future<int> eliminaContatto(int id) async {
    final db = await database;
    return await db.delete('rubrica', where: 'id = ?', whereArgs: [id]);
  }

  //modifica un contatto
  Future<int> modificaContatto(Contatto c) async {
    final db = await database;
    return await db
        .update('rubrica', c.toMap(), where: 'id = ?', whereArgs: [c.id]);
  }

//id contatto
  Future<Contatto?> getContattoById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'rubrica',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (results.isNotEmpty) {
      return Contatto.fromMap(results.first);
    } else {
      return null;
    }
  }

  //per i contatti preferiti
  String _prefContatto = 'prefConatto';
  //salva  preferenza
  Future<void> salvaContattoPreferito(Contatto contatto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> idContattiPreferiti = [contatto.id.toString()];
    await prefs.setStringList(_prefContatto, idContattiPreferiti);
  }

//get contatto pref
  Future<List<Contatto>> getContattiPreferiti() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? idContattiPreferiti = prefs.getStringList(_prefContatto);
    if (idContattiPreferiti != null) {
      List<Contatto> contattiPreferiti = [];
      for (String idContatto in idContattiPreferiti) {
        Contatto? contatto =
            await instance.getContattoById(int.parse(idContatto));
        if (contatto != null) {
          contattiPreferiti.add(contatto);
        }
      }
      return contattiPreferiti;
    } else {
      return [];
    }
  }
}
