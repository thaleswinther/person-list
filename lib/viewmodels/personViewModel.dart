import 'package:flutter/material.dart';
import '../persistence/person.dart';
import '../persistence/appDatabase.dart';

class PersonViewModel extends ChangeNotifier {
  final AppDatabase _database;

  PersonViewModel(this._database) {
    _loadPersons();
  }

  Stream<List<Person>>? _personsStream;
  Stream<List<Person>>? get personsStream => _personsStream;

  void _loadPersons() {
    _personsStream = _database.personDao.findAllPersons();
    notifyListeners();
  }

  Future<void> addPerson(String name, int age) async {
    final person = Person(name: name, age: age);
    await _database.personDao.insertPerson(person);
  }
}
