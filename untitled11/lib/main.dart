import 'package:flutter/material.dart';
import 'package:untitled11/home_screen.dart';
import 'package:untitled11/services/database_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseServices.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Görev Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // HomeScreen burada kullanılıyor
    );
  }
}
