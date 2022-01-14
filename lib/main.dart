import 'package:flutter/material.dart';
import 'package:smartstart/Constanst.dart';
import 'package:smartstart/PhoneNumberAuthScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Constanst.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  PhoneNumberAuthScreen(),
    );
  }
}


