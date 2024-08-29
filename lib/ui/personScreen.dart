import 'package:flutter/material.dart';
import '../persistence/person.dart';
import '../viewmodels/personViewModel.dart';
import 'package:provider/provider.dart';

class PersonScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personViewModel = Provider.of<PersonViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Person List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16), // Adiciona um espaço de 16 pixels
                ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text;
                    final age = int.parse(_ageController.text);
                    personViewModel.addPerson(name, age);
                    _nameController.clear();
                    _ageController.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Person>>(
              stream: personViewModel.personsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No persons found'));
                } else {
                  final persons = snapshot.data!;
                  return ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      final person = persons[index];
                      return ListTile(
                        title: Text(person.name),
                        subtitle: Text('Age: ${person.age}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
