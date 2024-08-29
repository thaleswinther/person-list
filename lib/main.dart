import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'persistence/appDatabase.dart';
import 'viewmodels/personViewModel.dart';
import 'ui/personScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('appDatabase.db').build();

  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  MyApp(this.database);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PersonViewModel(database),
      child: MaterialApp(
        title: 'Person List',
        home: PersonScreen(),
      ),
    );
  }
}
