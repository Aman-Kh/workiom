import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/route_generator.dart';
import 'package:flutter_projects/providers/user_provider.dart';
import 'package:flutter_projects/providers/workspace_provider.dart';
import 'package:flutter_projects/views/welcome_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkSpaceProvider>(create: (_) => WorkSpaceProvider()),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: [RouteGenerator()],
        debugShowCheckedModeBanner: false,
        title: 'Workiom',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeView(),
      ),
    );
  }
}
