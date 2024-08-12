import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pid_controller/home.dart';
import 'package:pid_controller/switch/bloc/switch_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PID Controller V2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const TestPage(),
      home: MultiBlocProvider(
        providers: [
            BlocProvider<SwitchBloc>(
              create: (context) => SwitchBloc(),
            ),
          ],
        child: const MyHomePage()),
    );
  }
}


