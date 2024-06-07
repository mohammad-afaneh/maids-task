import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maidstask/utils/MySharedPreferences.dart';
import 'package:maidstask/view/Login_Screen.dart';
import 'package:maidstask/view/home_screen.dart';
import 'package:provider/provider.dart';

import 'controller/database_sqlite.dart';
import 'controller/provider/tasks.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await MySharedPreferences.init();
  await DatabaseHelper().initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Tasks>(create: (context) => Tasks()),
      ],
      child: MaterialApp(
        title: 'Maids Task Manager',
        debugShowCheckedModeBanner: false,
        home: MySharedPreferences.isLogIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
