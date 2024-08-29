import 'package:floor/floor.dart';
import 'person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Stream<List<Person>> findAllPersons();

  @insert
  Future<void> insertPerson(Person person);
}
